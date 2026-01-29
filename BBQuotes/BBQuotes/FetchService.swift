//
//  FetchService.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import Foundation

struct FetchService {
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    enum FetchError: Error {
        case badResponse
        case dataDecodingError
        case characterNotFound
    }
    
    enum ShowType: String {
        case breakingBad = "Breaking+Bad"
        case betterCallSaul = "Better+Call+Saul"
        case elCamino = "El+Camino"
    }
    
    //throws: An error when the operation cannot be completed
    func fetchQuote(from show: ShowType) async throws -> Quote {
        let quotesURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quotesURL.appending(queryItems: [URLQueryItem(name: "production", value: show.rawValue)])
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        print("Fetching from URL: \(fetchURL)")
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        if let quote = try? JSONDecoder().decode(Quote.self, from: data) {
            return quote
        } else {
            throw FetchError.dataDecodingError
        }
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        let quotesURL = baseURL.appending(path: "characters")
        let fetchURL = quotesURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let char = try? decoder.decode([Char].self, from: data) { // char is array
            guard let character = char.first else {
                throw FetchError.characterNotFound
            }
            return character
        } else {
            throw FetchError.dataDecodingError
        }
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let deaths = try? decoder.decode([Death].self, from: data) {
            for death in deaths {
                if death.character == character {
                    return death
                }
            }
            return nil
        } else {
            throw FetchError.dataDecodingError
        }
    }
}

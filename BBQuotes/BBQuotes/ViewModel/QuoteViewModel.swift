//
//  QuoteViewModel.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import Foundation

@Observable
@MainActor
class QuoteViewModel {
    enum FetchStatus {
        case notStarting
        case fetching
        case successQuote
        case successEpisode
        case failure(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarting
    let service: FetchService = FetchService()
    var quote: Quote
    var character: Char
    var death: Death?
    var episode: Episode
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let quoteURL = Bundle.main.url(forResource: "samplequote", withExtension: "json"),
           let quoteData = try? Data(contentsOf: quoteURL),
           let decodedQuote = try? decoder.decode(Quote.self, from: quoteData) {
            quote = decodedQuote
        } else {
            quote = Quote.mockQuote
        }
        
        if let charURL = Bundle.main.url(forResource: "samplecharacter", withExtension: "json"),
           let charData = try? Data(contentsOf: charURL),
           let decodedChar = try? decoder.decode(Char.self, from: charData) {
            character = decodedChar
        } else {
            character = Char.mockWalterWhite
        }
        
        if let episodeURL = Bundle.main.url(forResource: "sampleepisode", withExtension: "json"),
           let episodeData = try? Data(contentsOf: episodeURL),
           let decodedEpisode = try? decoder.decode(Episode.self, from: episodeData) {
            episode = decodedEpisode
        } else {
            episode = Episode.mockEpisode
        }
    }
    
    func getQuoteData(from showType: FetchService.ShowType) async {
        status = .fetching
        do {
            quote = try await service.fetchQuote(from: showType)
            character = try await service.fetchCharacter(quote.character)
            character.death = try await service.fetchDeath(for: character.name)
            status = .successQuote
        } catch {
            status = .failure(error: error)
        }
    }
    
    func getEpisodeData(from showType: FetchService.ShowType) async {
        status = .fetching
        do {
            episode = try await service.fetchEpisode(from: showType)
            status = .successEpisode
        } catch {
            status = .failure(error: error)
        }
    }
}

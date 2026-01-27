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
        case success
        case failure(error: Error)
    }
    
    let service: FetchService = FetchService()
    var quote: Quote
    var character: Char
    var death: Death?
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Bundle'dan yüklemeyi dene, başarısız olursa varsayılan değerler kullan (Preview desteği için)
        if let quoteURL = Bundle.main.url(forResource: "samplequote", withExtension: "json"),
           let quoteData = try? Data(contentsOf: quoteURL),
           let decodedQuote = try? decoder.decode(Quote.self, from: quoteData) {
            quote = decodedQuote
        } else {
            quote = Quote(quote: "I am the one who knocks!", character: "Walter White", production: "Breaking Bad", episode: 1)
        }
        
        if let charURL = Bundle.main.url(forResource: "samplecharacter", withExtension: "json"),
           let charData = try? Data(contentsOf: charURL),
           let decodedChar = try? decoder.decode(Char.self, from: charData) {
            character = decodedChar
        } else {
            character = Char(
                name: "Walter White",
                birthday: "09-07-1958",
                occupations: ["Chemistry Teacher"],
                images: [URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!],
                aliases: ["Heisenberg"],
                status: "Dead",
                portrayedBy: "Bryan Cranston",
                death: nil
            )
        }
    }
    
    private(set) var status: FetchStatus = .notStarting
    
    func getData(from showType: FetchService.ShowType) async {
        status = .fetching
        do {
            quote = try await service.fetchQuote(from: showType)
            character = try await service.fetchCharacter("Walter White")
            death = try await service.fetchDeath(for: character.name)
            status = .success
        } catch {
            status = .failure(error: error)
        }
    }
}

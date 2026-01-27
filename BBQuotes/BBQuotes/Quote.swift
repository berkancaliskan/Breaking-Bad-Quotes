//
//  Quote.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
    let episode: Int
    
    init(quote: String, character: String, production: String, episode: Int) {
        self.quote = quote
        self.character = character
        self.production = production
        self.episode = episode
    }
}

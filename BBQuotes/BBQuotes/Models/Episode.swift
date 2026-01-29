//
//  Episode.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 29.01.2026.
//

import Foundation

struct Episode: Decodable {
    let episodeId: Int
    let production: String
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    var seasonEpisode: String {
        return "Season:\(episode/100) Episode:\(episode%100)"
    }
}

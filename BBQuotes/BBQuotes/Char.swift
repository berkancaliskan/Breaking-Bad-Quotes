//
//  Char.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import Foundation

struct Char: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death?
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy = "portrayed_by"
        case death
    }
    
    init(name: String, birthday: String, occupations: [String], images: [URL], aliases: [String], status: String, portrayedBy: String, death: Death? = nil) {
        self.name = name
        self.birthday = birthday
        self.occupations = occupations
        self.images = images
        self.aliases = aliases
        self.status = status
        self.portrayedBy = portrayedBy
        self.death = death
    }
}

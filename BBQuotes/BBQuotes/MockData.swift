//
//  MockData.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import Foundation

extension Char {
    static let mockWalterWhite = Char(
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

extension Quote {
    static let mockQuote = Quote(quote: "I am the one who knocks!",
                                 character: "Walter White",
                                 production: "Breaking Bad",
                                 episode: 1)
}


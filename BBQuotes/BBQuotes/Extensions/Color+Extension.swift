//
//  Color+Extension.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 29.01.2026.
//

import SwiftUI

extension Color {
    static func getButtonColor(_ showType: Char.ShowType) -> Color {
        return switch showType {
        case .betterCallSaul: .betterCallSaulBlue
        case .breakingBad: .breakingBadGreen
        case .elCamino: .elCaminoRed
        }
    }
}

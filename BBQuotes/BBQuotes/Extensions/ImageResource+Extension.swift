//
//  ImageResource+Extension.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 29.01.2026.
//

import SwiftUI

extension ImageResource {
    static func getImage(_ showType: Char.ShowType) -> ImageResource {
        let imageResource: ImageResource = switch showType {
        case .breakingBad: .breakingBad
        case .betterCallSaul: .betterCallSaul
        case .elCamino: .elCamino
        }
        return imageResource
    }
}

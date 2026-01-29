//
//  ContentView.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                Tab("Breaking Bad" , systemImage: "tortoise.circle") {
                    QuoteView(showType: .breakingBad)
                }
                Tab("Better Call Saul" , systemImage: "briefcase.circle"){
                    QuoteView(showType: .betterCallSaul)
                }
                Tab("El Camino" , systemImage: "car.circle"){
                    QuoteView(showType: .elCamino)
                }
            }
            .tint(.mint)
        }
    }
}

#Preview {
    ContentView()
}

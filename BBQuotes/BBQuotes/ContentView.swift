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
                    QuoteView(isBreakingBadTab: true)
                }
                
                Tab("Better Call Saul" , systemImage: "briefcase.circle"){
                    QuoteView(isBreakingBadTab: false)
                }
            }
            
            .tint(.green)
            
        }
        .onAppear {
        }
    }
}

#Preview {
    ContentView()
}

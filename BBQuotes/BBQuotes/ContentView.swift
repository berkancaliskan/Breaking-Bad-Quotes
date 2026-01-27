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
                    Image(.breakingBad)
                        .resizable()
                        .scaledToFit()
                }
                
                Tab("Better Call Saul" , systemImage: "briefcase.circle"){
                    Image(.betterCallSaul)
                        .resizable()
                        .scaledToFit()
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

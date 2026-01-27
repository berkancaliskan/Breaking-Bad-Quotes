//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import SwiftUI

struct QuoteView: View {
    let vm = QuoteViewModel()
    let isBreakingBadTab: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(isBreakingBadTab ? .breakingBad : .betterCallSaul)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height)
                VStack {
                    Text("\"\(vm.quote.quote)\"")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal)
                    
                    ZStack(alignment: .bottom) {
                        AsyncImage(url: vm.character.images[0]) { image in
                               image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width/1.1,
                               height: geo.size.height/1.8)

                        Text(vm.quote.character)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                
                    }
                    .frame(width: geo.size.width/1.1,
                           height: geo.size.height/1.8)
                    .clipShape(.rect(cornerRadius: 50))
                    
                    Button {
                        
                    } label: {
                        Text("Get Random Quote")
                            .padding()
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .background(.green)
                            .buttonStyle(.bordered)
                            .clipShape(.capsule)
                    }
                    .padding(.top)
                
                    
                    
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(isBreakingBadTab: true)
}

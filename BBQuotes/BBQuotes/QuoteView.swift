//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import SwiftUI

struct QuoteView: View {
    @State private var vm = QuoteViewModel()
    let isBreakingBadTab: Bool
    @State var showCharacterInfo: Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(isBreakingBadTab ? .breakingBad : .betterCallSaul)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height)
                VStack {
                    Spacer(minLength: 60)
                    switch vm.status {
                    case .notStarting:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .scaleEffect(5)
                    case .success:
                        Text("\"\(vm.quote.quote)\"")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
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
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(15)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                            
                        }
                        .frame(width: geo.size.width/1.1,
                               height: geo.size.height/1.8)
                        .clipShape(.rect(cornerRadius: 50))
                        .onTapGesture {
                            showCharacterInfo.toggle()
                            
                        }
                    case .failure(let error):
                        Text(error.localizedDescription)
                    }
                    Spacer()
                    Button {
                        Task {
                            await vm.getData(from: isBreakingBadTab ? .breakingBad : .betterCallSaul)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .padding()
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .background(isBreakingBadTab ? .breakingBadGreen : .betterCallSaulBlue)
                            .buttonStyle(.bordered)
                            .clipShape(.capsule)
                    }
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(character: vm.character,
                          showType: isBreakingBadTab ? .breakingBad : .betterCallSaul)
        }
    }
}

#Preview {
    QuoteView(isBreakingBadTab: true)
}

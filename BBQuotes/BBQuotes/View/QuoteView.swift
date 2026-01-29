//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import SwiftUI

struct QuoteView: View {
    @State private var vm = QuoteViewModel()
    let showType: Char.ShowType
    @State var showCharacterInfo: Bool = false
    @State private var hasLoaded = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(ImageResource.getImage(showType))
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
                    case .successQuote:
                        Text("\"\(vm.quote.quote)\"")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                            .padding()
                            .background(.black.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.horizontal)
                        
                        ZStack(alignment: .bottom) {
                            if let randomURL = vm.character.images.randomElement() {
                            AsyncImage(url: randomURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width/1.1,
                                       height: geo.size.height/1.8)
                            } else {
                                Image(ImageResource.getImage(showType))
                                    .frame(width: geo.size.width/1.1,
                                               height: geo.size.height/1.8)
                            }
                                
                            
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
                    case .successEpisode:
                        EpisodeView(episode: vm.episode)
                    case .failure(let error):
                        Text(error.localizedDescription)
                    }
                    Spacer()
                    HStack {
                        Button {
                            Task {
                                await vm.getQuoteData(from: getShowType())
                            }
                        } label: {
                            Text("Get Random\nQuote")
                                .padding()
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                                .background(Color.getButtonColor(showType))
                                .clipShape(.capsule)
                        }
                        Button {
                            Task {
                                await vm.getEpisodeData(from: getShowType())
                            }
                        } label: {
                            Text("Get Random\nEpisode")
                                .padding()
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                                .background(Color.getButtonColor(showType))
                                .clipShape(.capsule)
                        }
                        
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
                          showType: self.showType)
        }
        .onAppear {
            Task {
                guard !hasLoaded else { return }
                hasLoaded = true
                await vm.getQuoteData(from: getShowType())
            }
        }
    }
}

#Preview {
    QuoteView(showType: .elCamino)
}

extension QuoteView {
    func getShowType() -> FetchService.ShowType {
        return switch showType {
        case .betterCallSaul: .betterCallSaul
        case .breakingBad: .breakingBad
        case .elCamino: .elCamino
        }
    }
}

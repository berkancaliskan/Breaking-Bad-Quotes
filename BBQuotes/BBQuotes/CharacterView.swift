//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Berkan Çalışkan on 27.01.2026.
//

import SwiftUI

struct CharacterView: View {
    
    let character: Char
    let showType: Char.ShowType
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(showType == .breakingBad ? .breakingBad : .betterCallSaul)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    .overlay {
                        LinearGradient(
                            stops: [
                                .init(color: Color(.systemBackground).opacity(0.25), location: 0.7),
                                .init(color: Color(.systemBackground).opacity(0.50), location: 0.8),
                                .init(color: Color(.systemBackground).opacity(0.75), location: 0.9),
                                .init(color: Color(.systemBackground), location: 1.0)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                ScrollView {
                    AsyncImage(url: character.images[0]) { image in
                           image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.2,
                           height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60)
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.headline)
                        Divider()
                        Text("\(character.name) Character Info")
                            .font(.title2)
                            .bold()
                        
                        Text("Born:\(character.birthday)")

                        Divider()
                        Text("Occupations:")
                            .font(.headline)
                            .bold()
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("• \(occupation)")
                        }
                        Divider()
                        Text("Nicknames:")
                            .font(.headline)
                            .bold()
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self) { alies in
                                Text("• \(alies)")
                                    .font(.subheadline)
                                    .bold()
                            }
                        } else  {
                            Text("None")
                                .font(.subheadline)
                        }
                        Divider()
                        DisclosureGroup("Status: (spoiler alert!):") {
                            VStack(alignment: .leading) {
                                Text(character.status)
                                    .font(.title2)
                                if let death = character.death {
                                    AsyncImage(url: death.image) { image in
                                           image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text("How: \(death.details)")
                                    Text("Last Words: \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer(minLength: 25)
                    }
                    .frame(width: geo.size.width / 1.25, alignment: .leading)
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: QuoteViewModel().character, showType: .breakingBad)
}

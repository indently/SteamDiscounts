//
//  ContentView.swift
//  AnotherTest
//
//  Created by Federico on 30/10/2021.
//

import SwiftUI


struct ContentView: View {
    @State var games = [Game]()
    
    var body: some View {
        NavigationView {
            List(games) { game in
                NavigationLink(destination: Text("\(game.title)")) {
                    HStack(spacing: 30) {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: game.thumb) ?? URL(string: "https://loremflickr.com/640/360")!) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 100, height: 50)
                        } else {
                            // Handle older versions
                        }
                        
                        VStack(alignment: .leading) {
                            Text("\(game.title)").bold().lineLimit(1)
                            Text("Originally: \(game.normalPrice)$")
                            Text("Discounted: \(game.salePrice)$").foregroundColor(.red)
                            Text("Rating: \(game.steamRatingPercent)%")
                        }
                    }
                }
            }.onAppear() {
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=5") { games in
                    self.games = games
                }
                
            }.navigationTitle("Steam Games")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

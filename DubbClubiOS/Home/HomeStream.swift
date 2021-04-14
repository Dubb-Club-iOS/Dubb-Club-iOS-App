//
//  HomeStream.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct HomeStream: View {
    @State private var upcomingGames = [UpcomingGame]()
    private var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    
    func getUpcomingGames() {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getUpcomingGamesFromDb") {
                let data = try Data(contentsOf: file)
                let upcomingGames: [UpcomingGame] = try! JSONDecoder().decode([UpcomingGame].self, from: data)
                self.upcomingGames = upcomingGames
                print("upcoming games request success")
            } else {
                print("could not get games")
                #if DEBUG //this is so previews work
                self.upcomingGames = testGames
                #endif
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    ColorManager.backgroundGray
                        .ignoresSafeArea()
                    
                    ScrollView {
                        LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                            ForEach(upcomingGames, id: \.self) { game in
                                PredictionCard(game: game)
                                    .frame(height: geometry.size.height / 2.2)
                                    .cornerRadius(10)
                                    .aspectRatio(1, contentMode: .fit)
                                
                            }
                        }
                        
                        //                    }
                    }.onAppear(perform: {
                        getUpcomingGames()
                    })
                }
                .navigationTitle("Upcoming Games")//.navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            
        }
        
    }
}

struct HomeStream_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeStream()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        //        HomeStream()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        //            .previewDisplayName("iPhone 12 Pro Max")
        
        //        HomeStream().previewDevice("iPhone SE (2nd generation)")
    }
}

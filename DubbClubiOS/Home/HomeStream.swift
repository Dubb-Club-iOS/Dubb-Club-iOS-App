//
//  HomeStream.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct HomeStream: View {
    @Binding var upcomingGames: [UpcomingGame]
    var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    
    
    
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
                    }
                    //                    .onAppear(perform: {
                    //                        getUpcomingGames()
                    //                    })
                }
                .navigationTitle("Upcoming Games")
                .navigationBarBackButtonHidden(true)
            }
            
        }
        
    }
}

struct HomeStream_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeStream_PreviewWrapper()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        //        HomeStream()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        //            .previewDisplayName("iPhone 12 Pro Max")
        
        //        HomeStream().previewDevice("iPhone SE (2nd generation)")
    }
    struct HomeStream_PreviewWrapper: View {
        @State var games = getUpcomingGames()
        
        var body: some View {
            HomeStream(upcomingGames: $games)
        }
    }
}

//
//  HomeStream.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct HomeStream: View {
    
    @Binding var upcomingGames: [UpcomingGame]
    @ObservedObject var userFaves: UserFaves
    @State var myGames: [UpcomingGame]
    @State var selection:Int = 0
    
    init(upcomingGames: Binding<[UpcomingGame]>, userFaves: UserFaves) {
        _upcomingGames = upcomingGames
        self.userFaves = userFaves
        let myGames: [UpcomingGame] = getMyGames(upcomingGames: upcomingGames, userFaves: userFaves)
        _myGames = State(initialValue: myGames)
        
    }
    
    
    var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    ColorManager.backgroundGray
                        .ignoresSafeArea()
                    
                    ScrollView {
                        Picker(selection: $selection, label: Text("SearchFilter")) {
                            Text("All Games").tag(0)
                            Text("Favorites Only").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.all, 10)
                        LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                            if selection == 0 {
                                ForEach(upcomingGames, id: \.self) { game in
                                    PredictionCard(game: game, userFaves: userFaves)
                                        .frame(height: geometry.size.height / 2.2)
                                        .cornerRadius(10)
                                        .aspectRatio(1, contentMode: .fit)
                                    
                                }
                            } else {
                                ForEach(myGames, id: \.self) { game in
                                    PredictionCard(game: game, userFaves: userFaves)
                                        .frame(height: geometry.size.height / 2.2)
                                        .cornerRadius(10)
                                        .aspectRatio(1, contentMode: .fit)
                                    
                                }.onReceive(self.userFaves.$nba, perform: { _ in
                                    self.myGames = getMyGames(upcomingGames: $upcomingGames, userFaves: userFaves)
                                })
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
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

func getMyGames(upcomingGames: Binding<[UpcomingGame]>, userFaves: UserFaves) -> [UpcomingGame] {
    var myGames: [UpcomingGame] = []
    for fave in userFaves.nba {
        let filtered = upcomingGames.wrappedValue.filter {
            ($0.away[0].teamId == fave || $0.home[0].teamId == fave) && !myGames.contains($0)
        }
        //            print(upcomingGames.wrappedValue)
        myGames.append(contentsOf: filtered)
    }
    myGames.sort{ $0.date < $1.date }
    return myGames
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
        @StateObject var userFaves = UserFaves(nba: [1, 2, 4, 17, 22])
        
        var body: some View {
            HomeStream(upcomingGames: $games, userFaves: userFaves)
        }
    }
}


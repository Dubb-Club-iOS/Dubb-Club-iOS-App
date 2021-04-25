//
//  TabUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/7/21.
//

import SwiftUI

struct TabUIView: View {
    @Binding var isLoggedIn: Bool
    @Binding var upcomingGames: [UpcomingGame]
    @Binding var standings: [[Team]]
    @ObservedObject var userFaves: UserFaves
    
    var body: some View {
        TabView {
            HomeStream(upcomingGames: $upcomingGames, userFaves: userFaves)
                .tabItem {
//                    Image(systemName: "house")
                    Image("logo_png")
                        .renderingMode(.template)
                    Text("Home")
                }
            SearchTab(userFaves: userFaves)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Standings(eastStandings: standings[0], westStandings: standings[1], userFaves: userFaves)
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Standings")
                }
            ProfileTab(isLoggedIn: $isLoggedIn, upcomingGames: $upcomingGames, userFaves: userFaves)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }.accentColor(.white)
    }
}

struct TabUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIView_PreviewWrapper()
        
    }
    struct TabUIView_PreviewWrapper: View {
        @State var games = getUpcomingGames()
        @State var standings = getTeams()
        @State var isLoggedIn = true
        @StateObject var userFaves = UserFaves()
        var body: some View {
            TabUIView(isLoggedIn: $isLoggedIn, upcomingGames: $games, standings: $standings, userFaves: userFaves)
        }
    }
}

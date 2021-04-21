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
    @State private var selection = "home"
    var body: some View {
        TabView(selection:$selection) {
            HomeStream(upcomingGames: $upcomingGames)
                .tabItem {
//                    Image(systemName: "house")
                    Image("logo_png")
                        .renderingMode(.template)
                    Text("Home")
                }
                .tag("home")
            SearchTab()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag("search")
            Standings(eastStandings: standings[0], westStandings: standings[1])
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Standings")
                }
            ProfileTab(isLoggedIn: $isLoggedIn, upcomingGames: $upcomingGames)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag("profile")
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
        var body: some View {
            TabUIView(isLoggedIn: $isLoggedIn, upcomingGames: $games, standings: $standings)
        }
    }
}

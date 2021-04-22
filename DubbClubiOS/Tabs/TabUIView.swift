//
//  TabUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/7/21.
//

import SwiftUI

struct TabUIView: View {
    @EnvironmentObject var life: Life
    @State var selection = "home"
    var body: some View {
        TabView(selection:$selection) {
            HomeStream()
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
            Standings(eastStandings: life.standings[0], westStandings: life.standings[1])
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Standings")
                }
            ProfileTab()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag("profile")
        }.accentColor(.white)
        .onAppear() {
            self.selection = "home"
        }.transition(.slide)
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
            TabUIView().environmentObject(Life(authenticated: true, upcomingGames: getUpcomingGames(), standings: getTeams()))
        }
    }
}

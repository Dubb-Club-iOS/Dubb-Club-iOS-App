//
//  TabUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/7/21.
//

import SwiftUI

struct TabUIView: View {
    @Binding var isLoggedIn: Bool
    @State private var selection = "home"
    var body: some View {
        TabView(selection:$selection) {
            SearchTab()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag("search")
            HomeStream()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag("home")
            ProfileTab(isLoggedIn: $isLoggedIn)
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
        TabUIView(isLoggedIn: .constant(false))
        
    }
}

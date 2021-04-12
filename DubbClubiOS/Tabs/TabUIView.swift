//
//  TabUIView.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/7/21.
//

import SwiftUI

struct TabUIView: View {
    var body: some View {
        TabView{
            HomeStream()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProfileTab()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct TabUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIView()
    }
}

//
//  ProfileTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/31/21.
//

import SwiftUI

struct ProfileTab: View {
    var body: some View {
        VStack {
            Text("@exampleUsername")
                .fontWeight(.bold)
            Spacer()
            Text("Teams Following:")
            TeamsFollowingList()
        }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}

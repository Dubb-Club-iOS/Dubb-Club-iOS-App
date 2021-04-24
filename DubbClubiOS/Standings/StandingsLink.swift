//
//  StandingsLink.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/23/21.
//

import SwiftUI

struct StandingsLink: View {
    @State private var showingPopover = false
    var team: Team
    @ObservedObject var userFaves: UserFaves
    
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                self.showingPopover = true
            }) {
                Image(team.teamName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.width)
            }
            .popover(isPresented: $showingPopover) {
                TeamDetail(userFaves: userFaves, teamId: team.teamId)
            }
        }
    }
}

struct StandingsLink_Previews: PreviewProvider {
    static var previews: some View {
        StandingsLink_PreviewWrapper()
    }
    struct StandingsLink_PreviewWrapper: View {
        @State var team = getTeams()[0][0]
        @StateObject var userFaves = UserFaves(nba: [1, 22])
        
        var body: some View {
            StandingsLink(team: team, userFaves: userFaves)
        }
    }
}

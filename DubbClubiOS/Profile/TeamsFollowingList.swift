//
//  TeamsFollowingList.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/29/21.
//

import SwiftUI

struct TeamsFollowingList: View {
    /*
    let cells = [
    TeamFollowingCell(),
    TeamFollowingCell(),
    TeamFollowingCell()
    ]
    */
    
    var body: some View {
        VStack {
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
            TeamFollowingCell()
        }
    }
}

struct TeamsFollowingList_Previews: PreviewProvider {
    static var previews: some View {
        TeamsFollowingList()
    }
}

//
//  Model.swift
//  DubbClubiOS
//
//  Created by Aditya Naik on 3/29/21.
//

import Foundation
import SwiftUI

struct TeamStandings: Codable {
    let teams: [TeamStanding]
}

struct TeamStanding: Codable {
    let teamId: Int
    let conference: String
    let standing: Int
    let wins: Int
    let losses: Int
    let lastTenWins: Int
    let lastTenLosses: Int
    let winStreak: Int
    let gamesBehind: Float
    func getStandingAsStr() -> String {
        let toRet: String = "\(teamId)" + " in standing " + "\(standing)" + " in the " + conference
        return toRet
    }
}

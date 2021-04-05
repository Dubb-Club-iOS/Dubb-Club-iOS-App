//
//  Model.swift
//  DubbClubiOS
//
//  Created by Aditya Naik on 3/29/21.
//

import Foundation
import SwiftUI

//struct TeamStandings: Codable {
//    let teams: [TeamStanding]
//}

struct Team: Codable {
    let teamId: Int
    let teamName: String
    let conference: String
    let standing: Int
    let wins: Int
    let losses: Int
    let lastTenWins: Int
    let lastTenLosses: Int
    let winStreak: Int
    let gamesBehind: Float
    func getStandingAsStr() -> String {
        return "\(teamName) in standing \(standing) in the \(conference)"
    }
}

struct TeamLite: Codable {
    let teamId: Int
    let teamName: String
    let conferenceName: String
    let place: Int
    let wins: Int
    let losses: Int
}

struct UpcomingGame: Codable {
    let confidence: Float
    let away: [TeamLite]
    let home: [TeamLite]
    let predictedWinner: Int
    let status: String
    let id: Int
    func getUpcomingGameAsStr() -> String {
        return "\(home[0].teamName) at \(away[0].teamName). Prediction: \(predictedWinner)"
    }
}

struct LoginInfo: Codable {
    let username: String
    let password: String
}

struct LoginReturn: Codable {
    let id: String
    let username: String
    let accessToken: String
    let expiresIn: Int
}

struct FavoriteTeamsParent: Codable {
    let favoriteTeams: FavoriteTeams
}

struct FavoriteTeams: Codable {
    let NBA: [Int]
}

struct RegistrationBody: Codable {
    let email: String
    let username: String
    let password: String
}

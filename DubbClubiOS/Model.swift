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

struct Team: Codable, Hashable {
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

struct TeamLite: Codable, Hashable {
    let teamId: Int
    let teamName: String
    let conferenceName: String
    let place: Int
    let wins: Int
    let losses: Int
}

struct UpcomingGame: Codable, Hashable {
    let confidence: Float
    let away: [TeamLite]
    let home: [TeamLite]
    let predictedWinner: Int
    let status: String
    let id: Int
    let date: String
    func getUpcomingGameAsStr() -> String {
        return "\(home[0].teamName) at \(away[0].teamName). Prediction: \(predictedWinner)"
    }
}

struct GameFromDbParent: Codable {
    let game: GameFromDb
}

struct GameFromDb: Codable {
    let confidence: Float
    let away: [TeamLite]
    let home: [TeamLite]
    let predictedWinner: Int
    let status: String
    let id: Int
    let date: String
    
    let playedGameStats: GameStats?
    
    func getUpcomingGameAsStr() -> String {
        return "\(home[0].teamName) at \(away[0].teamName). Prediction: \(predictedWinner)"
    }
}

struct PastGameForTeam: Codable {
    let gameId: String
    let date: String
    let home: TeamLite
    let away: TeamLite
    let gameStats: GameStats
}

struct GameStats: Codable {
    let home: TeamGameSummary
    let away: TeamGameSummary
}

struct TeamGameSummary: Codable {
    let teamId: String
    let points: String
    let lineScore: [String]
    let leaders: [PlayerStat]
}

struct PlayerStat: Codable {
    let points: String?
    let rebounds: String?
    let assists: String?
    let playerId: String
    let name: String
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

struct RefreshReturn: Codable {
    let id: String
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

struct FollowBody: Codable {
    let league: String
    let teamId: Int
}

let testGames = [DubbClubiOS.UpcomingGame(confidence: 0.5428479, away: [DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26)], home: [DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33)], predictedWinner: 15, status: "Scheduled", id: 9018, date: "2021-04-09T23:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.7571793, away: [DubbClubiOS.TeamLite(teamId: 22, teamName: "Minnesota Timberwolves", conferenceName: "west", place: 15, wins: 13, losses: 38)], home: [DubbClubiOS.TeamLite(teamId: 2, teamName: "Boston Celtics", conferenceName: "east", place: 7, wins: 25, losses: 25)], predictedWinner: 2, status: "Scheduled", id: 9020, date: "2021-04-09T23:30:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.5396515, away: [DubbClubiOS.TeamLite(teamId: 19, teamName: "Memphis Grizzlies", conferenceName: "west", place: 8, wins: 24, losses: 23)], home: [DubbClubiOS.TeamLite(teamId: 24, teamName: "New York Knicks", conferenceName: "east", place: 8, wins: 25, losses: 26)], predictedWinner: 19, status: "Scheduled", id: 9021, date: "2021-04-09T23:30:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.68561715, away: [DubbClubiOS.TeamLite(teamId: 6, teamName: "Chicago Bulls", conferenceName: "east", place: 10, wins: 21, losses: 28)], home: [DubbClubiOS.TeamLite(teamId: 1, teamName: "Atlanta Hawks", conferenceName: "east", place: 4, wins: 27, losses: 24)], predictedWinner: 1, status: "Scheduled", id: 9019, date: "2021-04-10T00:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.5232759, away: [DubbClubiOS.TeamLite(teamId: 27, teamName: "Philadelphia 76ers", conferenceName: "east", place: 1, wins: 35, losses: 16)], home: [DubbClubiOS.TeamLite(teamId: 23, teamName: "New Orleans Pelicans", conferenceName: "west", place: 11, wins: 22, losses: 28)], predictedWinner: 23, status: "Scheduled", id: 9023, date: "2021-04-10T00:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.6856176, away: [DubbClubiOS.TeamLite(teamId: 5, teamName: "Charlotte Hornets", conferenceName: "east", place: 5, wins: 25, losses: 24)], home: [DubbClubiOS.TeamLite(teamId: 21, teamName: "Milwaukee Bucks", conferenceName: "east", place: 3, wins: 32, losses: 17)], predictedWinner: 21, status: "Scheduled", id: 9024, date: "2021-04-10T01:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.8240769, away: [DubbClubiOS.TeamLite(teamId: 31, teamName: "San Antonio Spurs", conferenceName: "west", place: 9, wins: 24, losses: 24)], home: [DubbClubiOS.TeamLite(teamId: 9, teamName: "Denver Nuggets", conferenceName: "west", place: 4, wins: 32, losses: 18)], predictedWinner: 9, status: "Scheduled", id: 9025, date: "2021-04-10T01:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.52375865, away: [DubbClubiOS.TeamLite(teamId: 41, teamName: "Washington Wizards", conferenceName: "east", place: 13, wins: 17, losses: 32)], home: [DubbClubiOS.TeamLite(teamId: 11, teamName: "Golden State Warriors", conferenceName: "west", place: 10, wins: 23, losses: 27)], predictedWinner: 11, status: "Scheduled", id: 9026, date: "2021-04-10T02:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.55825293, away: [DubbClubiOS.TeamLite(teamId: 14, teamName: "Houston Rockets", conferenceName: "west", place: 14, wins: 13, losses: 37)], home: [DubbClubiOS.TeamLite(teamId: 16, teamName: "LA Clippers", conferenceName: "west", place: 3, wins: 33, losses: 18)], predictedWinner: 16, status: "Scheduled", id: 9027, date: "2021-04-10T02:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.56754416, away: [DubbClubiOS.TeamLite(teamId: 38, teamName: "Toronto Raptors", conferenceName: "east", place: 11, wins: 20, losses: 31)], home: [DubbClubiOS.TeamLite(teamId: 7, teamName: "Cleveland Cavaliers", conferenceName: "east", place: 12, wins: 18, losses: 32)], predictedWinner: 38, status: "Scheduled", id: 9022, date: "2021-04-10T23:30:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.64934814, away: [DubbClubiOS.TeamLite(teamId: 17, teamName: "Los Angeles Lakers", conferenceName: "west", place: 5, wins: 32, losses: 19)], home: [DubbClubiOS.TeamLite(teamId: 4, teamName: "Brooklyn Nets", conferenceName: "east", place: 1, wins: 36, losses: 16)], predictedWinner: 4, status: "Scheduled", id: 9028, date: "2021-04-11T00:30:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.63703936, away: [DubbClubiOS.TeamLite(teamId: 27, teamName: "Philadelphia 76ers", conferenceName: "east", place: 2, wins: 35, losses: 16)], home: [DubbClubiOS.TeamLite(teamId: 25, teamName: "Oklahoma City Thunder", conferenceName: "west", place: 13, wins: 20, losses: 31)], predictedWinner: 27, status: "Scheduled", id: 7707, date: "2021-04-11T01:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.5705741, away: [DubbClubiOS.TeamLite(teamId: 30, teamName: "Sacramento Kings", conferenceName: "west", place: 12, wins: 22, losses: 29)], home: [DubbClubiOS.TeamLite(teamId: 40, teamName: "Utah Jazz", conferenceName: "west", place: 1, wins: 38, losses: 12)], predictedWinner: 40, status: "Scheduled", id: 9029, date: "2021-04-11T01:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.5755337, away: [DubbClubiOS.TeamLite(teamId: 14, teamName: "Houston Rockets", conferenceName: "west", place: 14, wins: 14, losses: 37)], home: [DubbClubiOS.TeamLite(teamId: 11, teamName: "Golden State Warriors", conferenceName: "west", place: 10, wins: 24, losses: 27)], predictedWinner: 14, status: "Scheduled", id: 9030, date: "2021-04-11T02:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.8085188, away: [DubbClubiOS.TeamLite(teamId: 41, teamName: "Washington Wizards", conferenceName: "east", place: 13, wins: 18, losses: 32)], home: [DubbClubiOS.TeamLite(teamId: 28, teamName: "Phoenix Suns", conferenceName: "west", place: 2, wins: 35, losses: 14)], predictedWinner: 28, status: "Scheduled", id: 9031, date: "2021-04-11T02:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.7191335, away: [DubbClubiOS.TeamLite(teamId: 10, teamName: "Detroit Pistons", conferenceName: "east", place: 15, wins: 15, losses: 36)], home: [DubbClubiOS.TeamLite(teamId: 29, teamName: "Portland Trail Blazers", conferenceName: "west", place: 6, wins: 30, losses: 20)], predictedWinner: 29, status: "Scheduled", id: 9032, date: "2021-04-11T02:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.5455012, away: [DubbClubiOS.TeamLite(teamId: 1, teamName: "Atlanta Hawks", conferenceName: "east", place: 5, wins: 27, losses: 25)], home: [DubbClubiOS.TeamLite(teamId: 5, teamName: "Charlotte Hornets", conferenceName: "east", place: 4, wins: 26, losses: 24)], predictedWinner: 5, status: "Scheduled", id: 9033, date: "2021-04-11T17:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.53190583, away: [DubbClubiOS.TeamLite(teamId: 2, teamName: "Boston Celtics", conferenceName: "east", place: 7, wins: 26, losses: 26)], home: [DubbClubiOS.TeamLite(teamId: 9, teamName: "Denver Nuggets", conferenceName: "west", place: 4, wins: 33, losses: 18)], predictedWinner: 9, status: "Scheduled", id: 9034, date: "2021-04-11T19:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.61304736, away: [DubbClubiOS.TeamLite(teamId: 23, teamName: "New Orleans Pelicans", conferenceName: "west", place: 11, wins: 22, losses: 29)], home: [DubbClubiOS.TeamLite(teamId: 7, teamName: "Cleveland Cavaliers", conferenceName: "east", place: 12, wins: 18, losses: 32)], predictedWinner: 23, status: "Scheduled", id: 9035, date: "2021-04-11T23:00:00.000Z"), DubbClubiOS.UpcomingGame(confidence: 0.6898441, away: [DubbClubiOS.TeamLite(teamId: 21, teamName: "Milwaukee Bucks", conferenceName: "east", place: 3, wins: 32, losses: 18)], home: [DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 34)], predictedWinner: 21, status: "Scheduled", id: 9036, date: "2021-04-11T23:00:00.000")]

func getUpcomingGames() -> [UpcomingGame]{
    do {
        if let file = URL(string: "https://api.dubb.club/api/nba/getUpcomingGamesFromDb") {
            let data = try Data(contentsOf: file)
            let upcomingGames: [UpcomingGame] = try! JSONDecoder().decode([UpcomingGame].self, from: data)
            print("upcoming games request success")
            return upcomingGames
        } else {
            print("could not get games")
            #if DEBUG //this is so previews work
            return testGames
            #endif
        }
    } catch {
        print(error.localizedDescription)
        return []
    }
}

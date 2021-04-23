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
    let elo: Float
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

struct GameFromDb: Codable, Hashable {
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

struct PastGameForTeam: Codable, Hashable {
    let gameId: String
    let date: String
    let home: TeamLite
    let away: TeamLite
    let gameStats: GameStats
    func getPastGameAsStr() -> String {
        return "\(home.teamName) at \(away.teamName)"
    }
}

struct GameStats: Codable, Hashable {
    let home: TeamGameSummary
    let away: TeamGameSummary
}

struct TeamGameSummary: Codable, Hashable {
    let teamId: String
    let points: String
    let lineScore: [String]
    let leaders: [PlayerStat]
}

struct PlayerStat: Codable, Hashable {
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

func getUpcomingGames() -> [UpcomingGame] {
    do {
//        if (!isLoggedIn()) {
//            return []
//        }
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

func getTeams() -> [[Team]] {
    do {
        if let file = URL(string: "https://api.dubb.club/api/nba/getTeamsFromDb") {
            let data = try Data(contentsOf: file)
            let teamStandings: [Team] = try! JSONDecoder().decode([Team].self, from: data)
            var eastStandings = [Team]()
            var westStandings = [Team]()
            for team in teamStandings {
//                print(team)
                if team.conference == "east" {
                    eastStandings.append(team)
                } else {
                    westStandings.append(team)
                }
            }
            eastStandings = eastStandings.sorted(by: { $0.standing < $1.standing })
            westStandings = westStandings.sorted(by: { $0.standing < $1.standing })
            return [eastStandings, westStandings]
        } else {
            return []
        }
    } catch {
        print(error.localizedDescription)
        return []
    }
}

func followTeamFunc(urlStr: String, teamId: Int) {
    
    let followInfo = FollowBody(league: "NBA", teamId: teamId)
    guard let followEnc = try? JSONEncoder().encode(followInfo) else {
        print("Failed to encode login information")
        return
    }
    
    let url = URL(string: urlStr)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = followEnc
    request.addValue(UserDefaults.standard.object(forKey: "JWT") as! String, forHTTPHeaderField: "x-access-token")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
                print("Unable to follow!")
                return
            }
        }
        
        
        if let error = error {
            // Handle HTTP request error
            print("Error: \(error.localizedDescription)")
        } else if let data = data {
            // Handle HTTP request response
//            print("Followed team!")
        } else {
            print("Unexpected error!")
        }
    }.resume()
}


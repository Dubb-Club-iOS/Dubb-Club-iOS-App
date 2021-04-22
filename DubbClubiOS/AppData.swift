//
//  AppData.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/21/21.
//

import SwiftUI

class Life: ObservableObject {
    @Published var authenticated: Bool
    @Published var upcomingGames: [UpcomingGame]
    @Published var standings: [[Team]]
    @Published var favorites: [Int]
    
    init() {
        self.authenticated = isLoggedIn()
        self.upcomingGames = getUpcomingGames()
        self.standings = getTeams()
        self.favorites = []
        if (self.authenticated) {
            getFavoriteTeams()
        }
    }
    
    init (authenticated: Bool, upcomingGames: [UpcomingGame], standings: [[Team]]) {
        self.authenticated = authenticated
        self.upcomingGames = upcomingGames
        self.standings = standings
        self.favorites = []
    }
    
    func getFavoriteTeams() {

        let url = URL(string: "https://api.dubb.club/api/user/favoriteteamlist")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue(UserDefaults.standard.object(forKey: "JWT") as! String, forHTTPHeaderField: "x-access-token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    print("Invalid login!")
                    return
                } else if httpResponse.statusCode == 500 {
                    print("Database failure!")
                    return
                }
            }
            
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                // Handle HTTP request response
                let ret: FavoriteTeamsParent = try! JSONDecoder().decode(FavoriteTeamsParent.self, from: data)
//                print("Fav Teams: ")
//                for team in ret.favoriteTeams.NBA {
//                    print(team)
//                }
                DispatchQueue.main.async {
                    self.favorites = ret.favoriteTeams.NBA
                }
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
}

func isLoggedIn() -> Bool {
    let token = UserDefaults.standard.object(forKey: "JWT") as? String
    if token == nil {
        return false
    }
    return true
}

func getTeams() -> [[Team]] {
    do {
        if let file = URL(string: "https://api.dubb.club/api/nba/getTeamsFromDb") {
            let data = try Data(contentsOf: file)
            let teamStandings: [Team] = try! JSONDecoder().decode([Team].self, from: data)
            var eastStandings = [Team]()
            var westStandings = [Team]()
            for team in teamStandings {
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

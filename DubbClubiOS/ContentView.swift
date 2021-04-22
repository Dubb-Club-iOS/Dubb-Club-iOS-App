//
//  ContentView.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/22/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var standings = [Team]()
    @State var upcomingGames = [UpcomingGame]()
    
    @State var gameIds = [Int]()
    @State var gameObjs = [GameFromDb]()
    @State var gameStats: GameStats?
    
    @State var following = false
    
    func getTeams() {

        /*
         To make a request...

         The base URL is https://api.dubb.club/api/nba, to which you can add extensions such as the one
         below or others in the README in Google Drive.

         When you make a request, you also need to make a "model" to handle the request JSON. This is in the file Model.swift.
         The JSONDecoder() like will populate this object with the field specified. Also, if there are nested objects, those will need
         to also be models. It's tedious but I couldn't fina another way to do it.
         */

        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getTeamsFromDb") {
                let data = try Data(contentsOf: file)
                let teamStandings: [Team] = try! JSONDecoder().decode([Team].self, from: data)
                self.standings = teamStandings

            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }

    }
    
    func getUpcomingGames() {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getUpcomingGamesFromDb") {
                let data = try Data(contentsOf: file)
                let upcomingGames: [UpcomingGame] = try! JSONDecoder().decode([UpcomingGame].self, from: data)
                self.upcomingGames = upcomingGames
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameIdsForTeam(teamId: Int) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGamesByTeamFromDb/\(teamId)") {
                let data = try Data(contentsOf: file)
                let gameIds: [Int] = try! JSONDecoder().decode([Int].self, from: data)
                self.gameIds = gameIds
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameIdsForDate(date: String) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGamesByDateFromDb/\(date)") {
                let data = try Data(contentsOf: file)
                let gameIds: [Int] = try! JSONDecoder().decode([Int].self, from: data)
                self.gameIds = gameIds
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameById(gameId: Int) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGameFromDb/\(gameId)") {
                let data = try Data(contentsOf: file)
                print(gameId)
                let game: GameFromDbParent = try! JSONDecoder().decode(GameFromDbParent.self, from: data)
                self.gameObjs.append(game.game)
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGamesForTeam(teamId: Int) {
        getGameIdsForTeam(teamId: teamId)
        for gameId in gameIds {
            getGameById(gameId: gameId)
        }
    }
    
    func getGamesForDate(date: String) {
        getGameIdsForDate(date: date)
        for gameId in gameIds {
            getGameById(gameId: gameId)
        }
    }
    
    func getRecentGamesByTeam() {
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
                print("Fav Teams: ")
                for team in ret.favoriteTeams.NBA {
                    print(team)
                }
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    func followTeam(teamId: Int) {
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/favoriteteam", teamId: teamId)
    }
    
    func unfollowTeam(teamId: Int) {
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/unfavoriteteam", teamId: teamId)
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
                print("Followed team!")
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
    // TODO: use elsewhere
    
    
    func getPastGameDetailsById(gameId: Int) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGameDetailsByGameId/\(gameId)") {
                let data = try Data(contentsOf: file)
                let stats: GameStats = try! JSONDecoder().decode(GameStats.self, from: data)
                self.gameStats = stats
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        // Temp UI
//        List(gameStats, id: \.home.teamId) { item in
//            VStack(alignment: .leading) {
//                Text("\(item.home[0].teamName) @ \(item.away[0].teamName)")
//            }
//        }.onAppear{ getGamesForDate(date: "2021-03-29T23:30:00.000Z") }
//        Text("\(self.gameStats?.home.teamId ?? "") @ \(self.gameStats?.away.teamId ?? "")").onAppear {
//            getPastGameDetailsById(gameId: 9007)
            Button(action: {
                if self.following {
                    unfollowTeam(teamId: 25)
                    self.following = false
                } else {
                    followTeam(teamId: 25)
                    self.following = true
                }
            }, label: {
                Text(self.following ? "Unfollow" : "Follow")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .cornerRadius(12.0)
            }).padding(.all, 20)
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

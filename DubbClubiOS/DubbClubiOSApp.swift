//
//  DubbClubiOSApp.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/22/21.
//

import SwiftUI


func isLoggedIn() -> Bool {
    let token = UserDefaults.standard.object(forKey: "JWT") as? String
    if token == nil {
        return false
    }
    return true
}



@main
struct DubbClubiOSApp: App {
    
    @State var authenticated: Bool = isLoggedIn()
    @State var upcomingGames = getUpcomingGames()
    @State var standings = getTeams()
    @StateObject var userFaves = UserFaves()
    
    init() {
        refreshToken()
//        getUpcomingGames()
    }
    
    func refreshToken() {
        
        let token = UserDefaults.standard.object(forKey: "JWT") as? String
        if token == nil {
            print("No user logged in!")
            return
        }
        
        let url = URL(string: "https://api.dubb.club/api/auth/refresh")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.addValue(UserDefaults.standard.object(forKey: "JWT") as! String, forHTTPHeaderField: "x-access-token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode != 200 {
                    print("User token expired!")
                    UserDefaults.standard.set(nil, forKey:"JWT")
                    UserDefaults.standard.set(nil, forKey:"Username")
                    self.userFaves.getFavoriteTeams()
                    return
                }
            }
            
            if let error = error {
                // Handle HTTP request error
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                print("Successful refresh of JWT!")
                let refreshReturn: RefreshReturn = try! JSONDecoder().decode(RefreshReturn.self, from: data)
                UserDefaults.standard.set(refreshReturn.accessToken, forKey:"JWT")
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
    
//    func getUpcomingGames() {
//        do {
//            if let file = URL(string: "https://api.dubb.club/api/nba/getUpcomingGamesFromDb") {
//                let data = try Data(contentsOf: file)
//                let upcomingGames: [UpcomingGame] = try! JSONDecoder().decode([UpcomingGame].self, from: data)
//                self.upcomingGames = upcomingGames
//                print("upcoming games request success")
//            } else {
//                print("could not get games")
//                #if DEBUG //this is so previews work
//                self.upcomingGames = testGames
//                #endif
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if authenticated {
                    TabUIView(isLoggedIn: $authenticated, upcomingGames: $upcomingGames, standings: $standings, userFaves: userFaves)
                } else {
                    LoginUIView(isLoggedIn: $authenticated, upcomingGames: $upcomingGames, userFaves: userFaves)
                        
                }
//                ContentView()
            }
        }
    }
    
    
}


class UserFaves: ObservableObject {
    
    @Published var nba: [Int]
    
    init() {
        self.nba = []
        if isLoggedIn() {
            getFavoriteTeams()
        }
    }
    init(nba: [Int]) { //for testing ONLY
        self.nba = nba
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
                    self.nba = ret.favoriteTeams.NBA
                }
            } else {
                print("Unexpected error!")
            }
        }.resume()
    }
}

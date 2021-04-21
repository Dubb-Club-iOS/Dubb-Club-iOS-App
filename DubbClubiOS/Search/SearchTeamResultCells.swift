//
//  SearchTeamResultCells.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/21/21.
//

import SwiftUI

struct SearchTeamResultCells: View {
    var inputTeamId: Int
    var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    @State var gameIds = [Int]()
    @State var gameObjs = [GameFromDb]()
    @State var upcomingGames = [UpcomingGame]()
    @State var pastGames = [PastGameForTeam]()
    
    init(inputTeamId: Int) {
        self.inputTeamId = inputTeamId
    }
    
    func getDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let UTCDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM/dd 'at' h:mm a" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
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
    
    func getUpcomingGamesFromGameList() {
        /*
         let now = Date()
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         
         //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
         let datetime = formatter.string(from: now)
         
         let nowFormatted = getDate(date: datetime)
         print(nowFormatted)
         */
        for game in gameObjs {
            /*
             let gameDate = game.date
             print(datetime.compare(gameDate, options: .caseInsensitive))
             if datetime.compare(gameDate, options: .caseInsensitive) != .orderedDescending {
             let gameToAdd = DubbClubiOS.UpcomingGame(confidence: game.confidence, away: game.away, home: game.home, predictedWinner: game.predictedWinner, status: game.status, id: game.id, date: game.date)
             self.upcomingGames.append(gameToAdd)
             }
             */
            if game.status != "Finished" {
                let gameToAdd = DubbClubiOS.UpcomingGame(confidence: game.confidence, away: game.away, home: game.home, predictedWinner: game.predictedWinner, status: game.status, id: game.id, date: game.date)
                self.upcomingGames.append(gameToAdd)
            }
            
        }
        print(self.upcomingGames.count)
    }
    
    func getPastGamesFromGameList() {
        /*
         let now = Date()
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         
         //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
         let datetime = formatter.string(from: now)
         
         let nowFormatted = getDate(date: datetime)
         print(nowFormatted)
         */
        for game in gameObjs {
            /*
             let gameDate = game.date
             print(datetime.compare(gameDate, options: .caseInsensitive))
             if datetime.compare(gameDate, options: .caseInsensitive) == .orderedDescending {
             let gameToAdd = DubbClubiOS.PastGameForTeam(gameId: String(game.id), date: game.date, home: game.home[0], away: game.away[0], gameStats: game.playedGameStats!)
             self.pastGames.append(gameToAdd)
             }
             */
            if game.status == "Finished" {
                let gameToAdd = DubbClubiOS.PastGameForTeam(gameId: String(game.id), date: game.date, home: game.home[0], away: game.away[0], gameStats: game.playedGameStats!)
                self.pastGames.append(gameToAdd)
            }
        }
        print(self.pastGames.count)
    }
    
    
    
    
    
    var body: some View {
    
        GeometryReader { geometry in
            VStack {
                //Text("Hello Test")
                //teamCell
                
                LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                    ForEach(upcomingGames, id: \.self) { gameItem in
                        SearchUpcomingGameCell(game: gameItem)
                            .frame(height: geometry.size.height / 2.2)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)

                    }
                }
                
                LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                    ForEach(pastGames, id: \.self) { gameItem in
                        SearchPastGameCell(game: gameItem)
                            .frame(height: geometry.size.height / 2.2)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)
                    }

                }
                

            }.onAppear(perform: {
                print(inputTeamId)
                getGamesForTeam(teamId: inputTeamId)
                getUpcomingGamesFromGameList()
                getPastGamesFromGameList()
            })
        }
    }
}

struct SearchTeamResultCells_Previews: PreviewProvider {
    static var previews: some View {
        SearchTeamResultCells(inputTeamId: 2)
    }
}

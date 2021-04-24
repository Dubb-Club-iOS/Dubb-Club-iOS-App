//
//  PastDetail.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PastDetail: View {

    @State var gameId: Int
    @State var gameStats: GameStats? =  nil
    
//    private static var periodScoreAway = ["27", "25", "27", "26"]
//    private static var periodScoreHome = ["24", "29", "23", "20"]
//
//    private static var awayPointLeader = PlayerStat(points: "40", rebounds: "", assists: "", playerId: "", name: "Malcolm Brogdon")
//    private static var awayAssistLeader = PlayerStat(points: "", rebounds: "", assists: "11", playerId: "", name: "Malcolm Brogdon")
//    private static var awayReboundLeader = PlayerStat(points: "", rebounds: "12", assists: "", playerId: "", name: "Domantas Sabonis")
//
//    private static var homePointLeader = PlayerStat(points: "35", rebounds: "", assists: "", playerId: "", name: "Terrence Ross")
//    private static var homeAssistLeader = PlayerStat(points: "", rebounds: "", assists: "8", playerId: "", name: "Markelle Fultz")
//    private static var homeReboundLeader = PlayerStat(points: "", rebounds: "9", assists: "", playerId: "", name: "Mo Bamba")
//    private static var awayleaders = [awayPointLeader, awayAssistLeader, awayReboundLeader]
//    private static var homeleaders = [homePointLeader, homeAssistLeader, homeReboundLeader]
    
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
    
//    var gameStats = GameStats(home: TeamGameSummary(teamId: "26", points: "104", lineScore: periodScoreHome, leaders: homeleaders), away: TeamGameSummary(teamId: "15", points: "110", lineScore: periodScoreAway, leaders: awayleaders))

    var body: some View {
        if self.gameStats == nil {
            ProgressView().onAppear {
                getPastGameDetailsById(gameId: gameId)
            }
        } else {
            GeometryReader { geometry in
                ColorManager.backgroundGray.ignoresSafeArea()
                VStack{
    //                LogosAndScores(homeScore: 104, awayScore: 110, homeId: 26, awayId: 15).frame(height: geometry.size.height / 2.8)
                    ScrollView{
                        VStack{
                            LogosAndScores(game: gameStats!).frame(height: geometry.size.height / 2.8)
                            PeriodScores(game: gameStats!).frame(width: geometry.size.width, height: geometry.size.height / 5)
                            GameLeaders(game: gameStats!).frame(width: geometry.size.width, height: geometry.size.height / 1.9)
                        }// end of VStack in scroll view
                    }// end of scroll view
                }// end of VStack
                .onAppear {
                    getPastGameDetailsById(gameId: self.gameId)
                }
                
            }// end of geometry
        }
        
    }// end of body
}// end of PastDetail

//struct PastDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PastDetail(gameId: 9018)
//    }
//}

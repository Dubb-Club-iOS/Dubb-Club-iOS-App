//
//  PastDetail.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PastDetail: View {
    
    private static var periodScoreAway = ["27", "25", "27", "26"]
    private static var periodScoreHome = ["24", "29", "23", "20"]
    
    private static var awayPointLeader = PlayerStat(points: "40", rebounds: "", assists: "", playerId: "", name: "Malcolm Brogdon")
    private static var awayAssistLeader = PlayerStat(points: "", rebounds: "", assists: "11", playerId: "", name: "Malcolm Brogdon")
    private static var awayReboundLeader = PlayerStat(points: "", rebounds: "12", assists: "", playerId: "", name: "Domantas Sabonis")
    
    private static var homePointLeader = PlayerStat(points: "35", rebounds: "", assists: "", playerId: "", name: "Terrence Ross")
    private static var homeAssistLeader = PlayerStat(points: "", rebounds: "", assists: "8", playerId: "", name: "Markelle Fultz")
    private static var homeReboundLeader = PlayerStat(points: "", rebounds: "9", assists: "", playerId: "", name: "Mo Bamba")
    private static var awayleaders = [awayPointLeader, awayAssistLeader, awayReboundLeader]
    private static var homeleaders = [homePointLeader, homeAssistLeader, homeReboundLeader]
    
    var game = DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "104", lineScore: periodScoreHome, leaders: homeleaders), away: TeamGameSummary(teamId: "15", points: "110", lineScore: periodScoreAway, leaders: awayleaders)))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.backgroundGray.ignoresSafeArea()
                VStack{
                    LogosAndScores(game: game).frame(height: geometry.size.height / 2.8)
                    ScrollView{
                        ZStack {
                            ColorManager.backgroundGray.ignoresSafeArea()
                            VStack{
                                PeriodScores(game: game).frame(width: geometry.size.width, height: geometry.size.height / 5).padding(.bottom, -16)
                                GameLeaders(game: game).frame(width: geometry.size.width, height: geometry.size.height / 1.9)
                            }// end of VStack in scroll view
                        } //end of ZStack in scroll view
                    }// end of scroll view
                }// end of VStack
            }// end of Zstack
            
        }// end of geometry
        
    }// end of body
}// end of PastDetail

struct PastDetail_Previews: PreviewProvider {
    static var previews: some View {
        PastDetail()
    }
}

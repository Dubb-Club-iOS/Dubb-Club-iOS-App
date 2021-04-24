//
//  PeriodScores.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PeriodScores: View {
    var game: PastGameForTeam
    
    var body: some View {
        let periodScoreAway = game.gameStats.away.lineScore
        let periodScoreHome = game.gameStats.home.lineScore
        GeometryReader { geometry in
            VStack{
                Text("Period Scores").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.9)
                HStack{
                    Image(teamIds[game.away.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreAway[0]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreAway[1]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreAway[2]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreAway[3]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    
                }
                HStack{
                    Image(teamIds[game.home.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreHome[0]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreHome[1]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreHome[2]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(periodScoreHome[3]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    
                }
            }
        }
    }
}

struct PeriodScores_Previews: PreviewProvider {
    static var previews: some View {
        let periodScoreAway = ["27", "25", "27", "26"]
        let periodScoreHome = ["24", "29", "23", "20"]
        PeriodScores(game: DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "26", lineScore: periodScoreHome, leaders: [PlayerStat]()), away: TeamGameSummary(teamId: "15", points: "42", lineScore: periodScoreAway, leaders: [PlayerStat]()))))
    }
}

//
//  PeriodScores2.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/24/21.
//










//DON'T USE, I DID THIS TO WORK WITH GRIDS SOME MORE AS A TEST











import SwiftUI

struct PeriodScores2: View {
    var game: PastGameForTeam
    var columns: [GridItem] =
        [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        let periodScoreAway = game.gameStats.away.lineScore
        let periodScoreHome = game.gameStats.home.lineScore
        GeometryReader { geometry in
                LazyVGrid(columns: columns, spacing: 4) {
                    Section(header:
                                HStack {Text("Period Scores")
                                .font(.title2)
                                .bold()
                                .frame(alignment: .leading)
                                    Spacer()
                                }
                    ) {
                        
                        VStack {
                            Image(teamIds[game.away.teamId]!).resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                            Image(teamIds[game.home.teamId]!).resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        }
                        VStack(alignment: .leading) {
                            Text(periodScoreAway[0]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                            Text(periodScoreHome[0]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        }
                        VStack(alignment: .leading) {
                            Text(periodScoreAway[1]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                            Text(periodScoreHome[1]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        }
                        VStack(alignment: .leading) {
                            Text(periodScoreAway[2]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                            Text(periodScoreHome[2]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        }
                        VStack(alignment: .leading) {
                            Text(periodScoreAway[3]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                            Text(periodScoreHome[3]).font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        }
                        
                    }
                }.padding([.top, .leading, .trailing])
               
        }
    }
}

struct PeriodScores2_Previews: PreviewProvider {
    static var previews: some View {
        let periodScoreAway = ["27", "25", "27", "26"]
        let periodScoreHome = ["24", "29", "23", "20"]
        PeriodScores2(game: DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "26", lineScore: periodScoreHome, leaders: [PlayerStat]()), away: TeamGameSummary(teamId: "15", points: "42", lineScore: periodScoreAway, leaders: [PlayerStat]()))))
    }
}

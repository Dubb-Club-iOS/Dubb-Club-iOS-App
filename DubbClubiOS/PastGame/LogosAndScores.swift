//
//  LogosAndScores.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct LogosAndScores: View {
    var game: PastGameForTeam
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                ZStack{
                    ColorManager.backgroundGray
                    VStack{
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(teamIds[game.away.teamId]!))
                                    .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.imageGray)
                                    .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                                Image(teamIds[game.away.teamId]!).resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                            }
                            Text("@").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                                .foregroundColor(.white).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: .center)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(teamIds[game.home.teamId]!))
                                    .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.imageGray)
                                    .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                                Image(teamIds[game.home.teamId]!).resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                            }
                        }// end of HStack of team logos
                        HStack{
                            let homeScore = game.gameStats.home.points
                            let awayScore = game.gameStats.away.points
                            
                            Text(awayScore).font(.largeTitle).fontWeight(.bold).frame(width: geometry.size.width / 2.8, height: geometry.size.width / 4)
                            Text("-").font(.largeTitle).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: .center)
                            Text(homeScore).font(.largeTitle).fontWeight(.bold).frame(width: geometry.size.width / 2.8, height: geometry.size.width / 4)
                        }
                    }
                }
            }
        }
    }
}

struct LogosAndScores_Previews: PreviewProvider {
    static var previews: some View {
        let stats = DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "26", lineScore: [String](), leaders: [PlayerStat]()), away: TeamGameSummary(teamId: "15", points: "42", lineScore: [String](), leaders: [PlayerStat]()))
        LogosAndScores(game: DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: stats))
    }
}

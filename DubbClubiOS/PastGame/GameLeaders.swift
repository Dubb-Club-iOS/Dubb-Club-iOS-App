//
//  GameLeaders.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/22/21.
//

import SwiftUI

struct GameLeaders: View {
    var game: PastGameForTeam
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Point Leaders").font(.title2).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.6)
                HStack{
                    Image(teamIds[game.away.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.away.leaders[0].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.away.leaders[0].points!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(teamIds[game.home.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.home.leaders[0].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.home.leaders[0].points!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                Text("Asist Leaders").font(.title2).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.6)
                HStack{
                    Image(teamIds[game.away.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.away.leaders[1].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.away.leaders[1].assists!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(teamIds[game.home.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.home.leaders[1].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.home.leaders[1].assists!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                Text("Rebound Leaders").font(.title2).fontWeight(.bold).lineLimit(1).padding(.trailing, geometry.size.width / 1.9)
                HStack{
                    Image(teamIds[game.away.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.away.leaders[2].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.away.leaders[2].rebounds!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(teamIds[game.home.teamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text(game.gameStats.home.leaders[2].name).font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text(game.gameStats.home.leaders[2].rebounds!).fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
            }
        }
    }
}

struct GameLeaders_Previews: PreviewProvider {
    static var previews: some View {
        
        let awayPointLeader = PlayerStat(points: "40", rebounds: "", assists: "", playerId: "", name: "Malcolm Brogdon")
        let awayAssistLeader = PlayerStat(points: "", rebounds: "", assists: "11", playerId: "", name: "Malcolm Brogdon")
        let awayReboundLeader = PlayerStat(points: "", rebounds: "12", assists: "", playerId: "", name: "Domantas Sabonis")
        
        let homePointLeader = PlayerStat(points: "35", rebounds: "", assists: "", playerId: "", name: "Terrence Ross")
        let homeAssistLeader = PlayerStat(points: "", rebounds: "", assists: "8", playerId: "", name: "Markelle Fultz")
        let homeReboundLeader = PlayerStat(points: "", rebounds: "9", assists: "", playerId: "", name: "Mo Bamba")
        let awayleaders = [awayPointLeader, awayAssistLeader, awayReboundLeader]
        let homeleaders = [homePointLeader, homeAssistLeader, homeReboundLeader]
        
        GameLeaders(game: DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "26", lineScore: [String](), leaders: homeleaders), away: TeamGameSummary(teamId: "15", points: "42", lineScore: [String](), leaders: awayleaders))))
    }
}

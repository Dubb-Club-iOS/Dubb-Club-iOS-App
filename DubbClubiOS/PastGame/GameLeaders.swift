//
//  GameLeaders.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/22/21.
//

import SwiftUI

struct GameLeaders: View {
    var game: GameStats
    var columns: [GridItem] =
            [
                GridItem(.flexible(), alignment: .leading),
                GridItem(.flexible(minimum: 190), alignment: .leading),
                GridItem(.flexible(), alignment: .leading),
            ]
    
    func getHomeLeaders() -> [PlayerStat] {
        
        var ret = [PlayerStat]()
        
        // [points, assists, rebounds]
        for player in game.home.leaders {
            //            var playerPoints = Int(player.points ?? "-1")
            //            var playerAssists = Int(player.assists ?? "-1")
            //            var playerRebounds = Int(player.rebounds ?? "-1")
            
            if (ret.count == 0) {
                ret.append(player)
                ret.append(player)
                ret.append(player)
            } else {
                // Points
                if (Int(ret[0].points ?? "-1")! < Int(player.points ?? "-1")!) {
                    ret[0] = player
                }
                
                // Rebounds
                if (Int(ret[1].assists ?? "-1")! < Int(player.assists ?? "-1")!) {
                    ret[1] = player
                }
                
                // Assists
                if (Int(ret[2].rebounds ?? "-1")! < Int(player.rebounds ?? "-1")!) {
                    ret[2] = player
                }
            }
        }
        
        return ret
    }
    
    func getAwayLeaders() -> [PlayerStat] {
        
        var ret = [PlayerStat]()
        
        // [points, assists, rebounds]
        for player in game.away.leaders {
            //            var playerPoints = Int(player.points ?? "-1")
            //            var playerAssists = Int(player.assists ?? "-1")
            //            var playerRebounds = Int(player.rebounds ?? "-1")
            
            if (ret.count == 0) {
                ret.append(player)
                ret.append(player)
                ret.append(player)
            } else {
                // Points
                if (Int(ret[0].points ?? "-1")! < Int(player.points ?? "-1")!) {
                    ret[0] = player
                }
                
                // Rebounds
                if (Int(ret[1].assists ?? "-1")! < Int(player.assists ?? "-1")!) {
                    ret[1] = player
                }
                
                // Assists
                if (Int(ret[2].rebounds ?? "-1")! < Int(player.rebounds ?? "-1")!) {
                    ret[2] = player
                }
            }
        }
        
        return ret
    }
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: columns, spacing: 4) {
                Section(header:
                            HStack {Text("Point Leaders")
                                .font(.title2)
                                .bold()
                                .frame(alignment: .leading)
                                Spacer()
                            }
                ) {
                    
                    VStack {
                        Image(teamIds[Int(game.away.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        Image(teamIds[Int(game.home.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    }
                    VStack(alignment: .leading) {
                        Text(getAwayLeaders()[0].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                        Text(getHomeLeaders()[0].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                    }
                    VStack {
                        Text(getAwayLeaders()[0].points!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                        Text(getHomeLeaders()[0].points!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                    }
                    
                }
                Section(header:
                            HStack {Text("Assist Leaders")
                                .font(.title2)
                                .bold()
                                .frame(alignment: .leading)
                                Spacer()
                            }
                ) {
                    
                    VStack {
                        Image(teamIds[Int(game.away.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        Image(teamIds[Int(game.home.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    }
                    VStack(alignment: .leading) {
                        Text(getAwayLeaders()[1].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                        Text(getHomeLeaders()[1].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                    }
                    VStack {
                        Text(getAwayLeaders()[1].assists!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                        Text(getHomeLeaders()[1].assists!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                    }
                    
                }
                Section(header:
                            HStack {Text("Rebound Leaders")
                                .font(.title2)
                                .bold()
                                .frame(alignment: .leading)
                                Spacer()
                            }
                ) {
                    
                    VStack {
                        Image(teamIds[Int(game.away.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                        Image(teamIds[Int(game.home.teamId)!]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    }
                    VStack(alignment: .leading) {
                        Text(getAwayLeaders()[2].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                        Text(getHomeLeaders()[2].name).font(.headline)
                            .frame(height: geometry.size.width / 10)
                    }
                    VStack {
                        Text(getAwayLeaders()[2].rebounds!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                        Text(getHomeLeaders()[2].rebounds!).fontWeight(.bold).font(.title3)
                            .frame(height: geometry.size.width / 10)
                        
                    }
                    
                }
                
            }
            //            .padding()
            .padding([.bottom, .leading, .trailing])
        }
    }
}

struct GameLeaders_Previews: PreviewProvider {
    static var previews: some View {



        GameLeaders(game: GameStats(home: DubbClubiOS.TeamGameSummary(teamId: "5", points: "109", lineScore: ["44", "21", "28", "16"], leaders: [DubbClubiOS.PlayerStat(points: Optional("5"), rebounds: nil, assists: nil, playerId: "1880", name: "Jalen McDaniels"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("3"), assists: nil, playerId: "458", name: "Terry Rozier"), DubbClubiOS.PlayerStat(points: nil, rebounds: nil, assists: Optional("10"), playerId: "458", name: "Terry Rozier"), DubbClubiOS.PlayerStat(points: Optional("34"), rebounds: nil, assists: nil, playerId: "458", name: "Terry Rozier"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("4"), assists: nil, playerId: "941", name: "Miles Bridges"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("8"), assists: nil, playerId: "1897", name: "P.J. Washington")]), away: DubbClubiOS.TeamGameSummary(teamId: "29", points: "101", lineScore: ["24", "27", "21", "29"], leaders: [DubbClubiOS.PlayerStat(points: Optional("18"), rebounds: nil, assists: nil, playerId: "347", name: "CJ McCollum"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("1"), assists: nil, playerId: "434", name: "Norman Powell"), DubbClubiOS.PlayerStat(points: nil, rebounds: nil, assists: Optional("2"), playerId: "398", name: "Jusuf Nurkic"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("7"), assists: nil, playerId: "291", name: "Enes Kanter"), DubbClubiOS.PlayerStat(points: Optional("8"), rebounds: nil, assists: nil, playerId: "398", name: "Jusuf Nurkic"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("3"), assists: nil, playerId: "1875", name: "Nassir Little"), DubbClubiOS.PlayerStat(points: nil, rebounds: nil, assists: Optional("6"), playerId: "347", name: "CJ McCollum"), DubbClubiOS.PlayerStat(points: nil, rebounds: Optional("5"), assists: nil, playerId: "347", name: "CJ McCollum"), DubbClubiOS.PlayerStat(points: Optional("24"), rebounds: nil, assists: nil, playerId: "21", name: "Carmelo Anthony")])))
    }
}

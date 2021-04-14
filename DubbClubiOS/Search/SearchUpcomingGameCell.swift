//
//  PredictionCard.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct SearchUpcomingGameCell: View {
    var game: UpcomingGame
    
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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.cardGray

                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(teamIds[game.away[0].teamId]!))
                                .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.imageGray)
                                .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                            Image(teamIds[game.away[0].teamId]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                        }
                        Text("@").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                            .foregroundColor(.white).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(teamIds[game.home[0].teamId]!))
                                .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.imageGray)
                                .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                        Image(teamIds[game.home[0].teamId]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                        }
                        Spacer()
                        
                    }
                    
                    DonutChart(game: game, charDataObj: ChartDataContainer(game: game), parentGeo: geometry)
//                        .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    
                    
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [ColorManager.dateGradientStart, ColorManager.dateGradientEnd]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: geometry.size.width, height: geometry.size.height / 10, alignment: .center)
                        Text(getDate(date: game.date)).fontWeight(.bold) .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing])
                    }
                }.padding([.top])
            }
        }
    }
}

struct SearchUpcomingGameCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchUpcomingGameCell(game: DubbClubiOS.UpcomingGame(confidence: 0.5428479, away: [DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26)], home: [DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33)], predictedWinner: 15, status: "Scheduled", id: 9018, date: "2021-04-09T23:00:00.000Z"))
    }
}

//                    HStack {
//
//                        Text("Minnesota Timberwolves").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .font(.title).lineLimit(2).minimumScaleFactor(0.1)
//                            .foregroundColor(.white).frame(width: geometry.size.width / 3, alignment: .center)
//
//                        Text("@").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .font(.largeTitle).lineLimit(1).minimumScaleFactor(0.1)
//                            .foregroundColor(.white).frame(width: geometry.size.width / 6, height: geometry.size.width / 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//
//                        Text("Utah Jazz").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .font(.title).lineLimit(2).minimumScaleFactor(0.1)
//                            .foregroundColor(.white).frame(width: geometry.size.width / 3, alignment: .center)
//                    }
//                    .frame(alignment: .leading)

//
//  PredictionCard.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//
import SwiftUI


struct SearchPastGameCell: View {
    var game: PastGameForTeam
    @ObservedObject var userFaves: UserFaves
    
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
            NavigationLink(destination: PastDetail(gameId: Int(game.gameId)!, userFaves: userFaves)) {
                ZStack {
                    ColorManager.cardGray
                    
                    VStack {
                        //Spacer()
                        VStack {
                            HStack {
                                Spacer()
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
                                Spacer()
                                let awayScore = game.gameStats.away.points
                                /*
                                Text(homeScore)
                                    .fontWeight(.bold)
                                    
                                    .font(.system(size: 500))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                                */
                                ZStack {
                                    if awayScore.count == 0 {
                                        Text("Not Available")
                                            .fontWeight(.bold)
                                            //.padding([.leading, .trailing], 4)
                                            .font(.system(size: geometry.size.width / 2.9))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    } else {
                                        Text(awayScore)
                                            .fontWeight(.bold)
                                            //.padding([.leading, .trailing], 4)
                                            .font(.system(size: geometry.size.width / 2.9))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    }
                                    Text("000")
                                        .fontWeight(.bold)
                                        //.padding([.leading, .trailing], 4)
                                        .font(.system(size: geometry.size.width / 2.9))
                                        .opacity(0.0)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.01)
                                    
                                }
                                
                                
                                
                                Spacer()
                            }.padding([.bottom], 4)
                            
                            Text("@")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.all, 4)
                                .font(.system(size: geometry.size.width / 7.3))
//                                .font(.largeTitle)
                                .minimumScaleFactor(0.1)
                            
                            HStack {
                                Spacer()
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
                                Spacer()
                                let homeScore = game.gameStats.home.points
                                /*
                                Text(awayScore)
                                    .fontWeight(.bold)
                                    .padding(.all, 8)
                                    .font(.system(size: 500))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                                */
                                ZStack {
                                    if homeScore.count == 0 {
                                        Text("Not Available")
                                            .fontWeight(.bold)
                                            //.padding([.leading, .trailing], 4)
                                            .font(.system(size: geometry.size.width / 2.9))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    } else {
                                        Text(homeScore)
                                            .fontWeight(.bold)
                                            //.padding([.leading, .trailing], 4)
                                            .font(.system(size: geometry.size.width / 2.9))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    }
                                    Text("000")
                                        .fontWeight(.bold)
                                        //.padding([.leading, .trailing], 4)
                                        .font(.system(size: geometry.size.width / 2.9))
                                        .opacity(0.0)
                                        .minimumScaleFactor(0.01)
                                    
                                }
                                
                                
                                Spacer()
                            }.padding([.top], 4)
                            
                        }.padding([.top, .bottom], 4)
                        //Spacer()
                        //Text(game.date)
                        Spacer()
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [ColorManager.dateGradientStart, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                //                            .fill(Color.blue)
                                .frame(width: geometry.size.width, height: geometry.size.height / 10, alignment: .center)
                            Text(getDate(date: game.date)).fontWeight(.bold) .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .padding([.leading, .trailing])
                        }
                    }.padding([.top])
                }//.padding([.top])
            }
        }
    }
}

//TODO: Fix preview later
//struct SearchPastGameCell_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let stats = DubbClubiOS.GameStats(home: TeamGameSummary(teamId: "2", points: "116", lineScore: [String](), leaders: [PlayerStat]()), away: TeamGameSummary(teamId: "15", points: "89", lineScore: [String](), leaders: [PlayerStat]()))
//        SearchPastGameCell(game: DubbClubiOS.PastGameForTeam(gameId: String(9018), date: "2021-04-09T23:00:00.000Z", home: DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33), away: DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26), gameStats: stats))
//    }
//}

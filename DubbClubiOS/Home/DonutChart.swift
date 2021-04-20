//
//  DonutChart.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/3/21.
//

import SwiftUI

import SwiftUI

//MARK:- Chart Data
struct ChartData {
    var id = UUID()
    var color : Color
    var percent : CGFloat
    var value : CGFloat
    
}

class ChartDataContainer : ObservableObject {
    @Published var chartData: [ChartData]
    //        =
    //        [ChartData(color: Color(teamIds[11]!), percent: 60, value: 0),
    //         ChartData(color: Color(teamIds[2]!), percent: 40, value: 0)]
    init(game: UpcomingGame) {
        self.chartData = gameToChartData(game: game)
    }
    
    func calc() -> Int {
        var winner = -1
        var value : CGFloat = 0
        
//        chartData = chartData.reversed()
        
        for i in 0..<chartData.count {
            if chartData[i].percent > 50 {
                winner = i
            }
            value += chartData[i].percent
            chartData[i].value = value
        }
        return winner
    }
}

func gameToChartData(game: UpcomingGame) -> [ChartData] {
    if (game.predictedWinner == game.away[0].teamId) {
        return
            [
                ChartData(color: Color(teamIds[game.home[0].teamId]!), percent: CGFloat((1 - game.confidence) * 100), value: 0),
                ChartData(color: Color(teamIds[game.away[0].teamId]!), percent: CGFloat(game.confidence * 100), value: 0)
            ]
    } else {
        return
            [
                ChartData(color: Color(teamIds[game.home[0].teamId]!), percent: CGFloat(game.confidence * 100), value: 0),
                ChartData(color: Color(teamIds[game.away[0].teamId]!), percent: CGFloat((1 - game.confidence) * 100), value: 0)
            ]
    }
}

struct DonutChart : View {
    var game: UpcomingGame
    @ObservedObject var charDataObj: ChartDataContainer
    @State var indexOfTappedSlice = -1
    
    var parentGeo: GeometryProxy
    
    func fontSize(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.height * 0.06
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<charDataObj.chartData.count) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                                  to:   charDataObj.chartData[index].value/100)
                            
                            .stroke(charDataObj.chartData[index].color,lineWidth: parentGeo.size.width * 0.075)
                            .rotationEffect(.degrees(-90))
                            .onTapGesture {
                                indexOfTappedSlice = index
                            }
                            //Scales the slice when tapped
                            .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                            .animation(.spring())
                    }
                    if indexOfTappedSlice != -1 {
                        Text(String(format: "%.2f", Double(charDataObj.chartData[indexOfTappedSlice].percent))+"%").fontWeight(.bold)
                            .font(.body).lineLimit(1).minimumScaleFactor(0.1)
                            .foregroundColor(.white)
                    }
                }.frame(height: parentGeo.size.height * 0.32)
                .onAppear(perform: {
                    indexOfTappedSlice = self.charDataObj.calc()
                })
                .padding()
                //                .onAppear() {
                //                    indexOfTappedSlice = self.charDataObj.calc()
                //                }
                
                if (indexOfTappedSlice == 0) {
                    Text("\(teamIds[game.home[0].teamId]!)").fontWeight(.bold)
                        .font(.system(size: fontSize(parentGeo)))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .leading, .trailing])
                        .foregroundColor(.white)
                } else if (indexOfTappedSlice == 1) {
                    Text("\(teamIds[game.away[0].teamId]!)").fontWeight(.bold)
                        .font(.system(size: fontSize(parentGeo)))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .leading, .trailing])
                        .foregroundColor(.white)
                    
                    
                }
                Spacer()
                Spacer()
                
            }
            
            
        }
        
    }
    
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        let game = DubbClubiOS.UpcomingGame(confidence: 0.5428479, away: [DubbClubiOS.TeamLite(teamId: 15, teamName: "Indiana Pacers", conferenceName: "east", place: 9, wins: 22, losses: 26)], home: [DubbClubiOS.TeamLite(teamId: 26, teamName: "Orlando Magic", conferenceName: "east", place: 14, wins: 17, losses: 33)], predictedWinner: 15, status: "Scheduled", id: 9018, date: "2021-04-09T23:00:00.000Z")
        GeometryReader { geometry in
            ZStack{
                ColorManager.backgroundGray
                DonutChart(game: game, charDataObj: ChartDataContainer(game: game), parentGeo: geometry)
            }
        }
    }
}

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
    @Published var chartData =
        [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 60, value: 0),
         //         ChartData(color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 25, value: 0),
         //         ChartData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 25, value: 0),
         ChartData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 40, value: 0)]
    
    //    ChartData(color: AngularGradient(gradient: Gradient(colors: [.red, .yellow]), center: .center, startAngle: .zero, endAngle: .degrees(360)), percent: 40, value: 0)]
    
    //    init() {
    //        //            chartData = chartData.reversed()
    //        calc()
    //    }
    func calc() -> Int {
        var winner = -1
        var value : CGFloat = 0
        
        chartData = chartData.reversed()
        
        for i in 0..<chartData.count {
            if chartData[i].percent > 50 {
                winner = i
            }
            value += chartData[i].percent
            chartData[i].value = value
        }
//        sleep(1)
        return winner
    }
}

struct DonutChart : View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
    var geometry: GeometryProxy
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<charDataObj.chartData.count) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                                  to:   charDataObj.chartData[index].value/100)
                            
                            .stroke(charDataObj.chartData[index].color,lineWidth: geometry.size.width * 0.1)
                            .rotationEffect(.degrees(-90))
                            .onTapGesture {
                                indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                            }
                            //Scales the slice when tapped
                            .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                            .animation(.spring())
                    }
                    if indexOfTappedSlice != -1 {
                        Text(String(format: "%.2f", Double(charDataObj.chartData[indexOfTappedSlice].percent))+"%").fontWeight(.bold)
                            .font(.body).lineLimit(1).minimumScaleFactor(0.08)
                            .foregroundColor(.white)
                    }
                }
                
                .padding()
                .onAppear() {
                   indexOfTappedSlice = self.charDataObj.calc()
        
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            
        }
        
    }
    
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ZStack{
                ColorManager.backgroundGray
                DonutChart(geometry: geometry)
            }
        }
    }
}

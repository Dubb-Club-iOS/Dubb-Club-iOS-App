//
//  PredictionCard.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct PredictionCard: View {
    var teamName1: String
    var teamName2: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.cardGray

                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.imageGray)
                                .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                        Image(teamName1).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                        }
                        Text("@").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                            .foregroundColor(.white).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(ColorManager.imageGray)
                                .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                        Image(teamName2).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                        }
                        Spacer()
                        
                    }
                    
                    DonutChart(geometry: geometry).frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                    HStack {
                        Text("\(teamName1):").fontWeight(.bold)
                            .font(.title).lineLimit(2).minimumScaleFactor(0.3).padding([.leading, .trailing])
                        Spacer()
                    }
                    
                    HStack {
                        Text("60.00% confidence").fontWeight(.bold)
                            .font(.title).lineLimit(1).minimumScaleFactor(0.1).padding([.leading, .trailing])
                        Spacer()
                    }
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [ColorManager.dateGradientStart, ColorManager.dateGradientEnd]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: geometry.size.width, height: geometry.size.height / 10, alignment: .center)
                        Text("04/10 at 8:00 pm").fontWeight(.bold) .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing])
                    }
                }.padding([.top])
            }
        }
    }
}

struct PredictionCard_Previews: PreviewProvider {
    static var previews: some View {
        PredictionCard(teamName1: "Minnesota Timberwolves", teamName2: "Sacramento Kings")
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

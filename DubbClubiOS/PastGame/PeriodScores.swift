//
//  PeriodScores.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PeriodScores: View {
    private var away = "Atlanta Hawks"
    private var home = "Indiana Pacers"
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Period Scores").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.9)
                HStack{
                    Image(away).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("25").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("27").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("27").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("27").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    
                }
                HStack{
                    Image(home).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("23").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("24").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("22").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("25").font(.title2).frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    
                }
            }
        }
    }
}

struct PeriodScores_Previews: PreviewProvider {
    static var previews: some View {
        PeriodScores()
    }
}

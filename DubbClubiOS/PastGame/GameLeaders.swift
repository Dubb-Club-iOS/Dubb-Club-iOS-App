//
//  GameLeaders.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/22/21.
//

import SwiftUI

struct GameLeaders: View {
    private var away = "Atlanta Hawks"
    private var home = "Indiana Pacers"
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Point Leaders").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.6)
                HStack{
                    Image(away).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Trae Young").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("34").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(home).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Malcolm Brogdon").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("29").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                Text("Asist Leaders").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/).fontWeight(.bold).padding(.trailing, geometry.size.width / 1.6)
                HStack{
                    Image(away).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Trae Young").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("34").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(home).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Malcolm Brogdon").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("29").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                Text("Rebound Leaders").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/).fontWeight(.bold).lineLimit(1).padding(.trailing, geometry.size.width / 1.9)
                HStack{
                    Image(away).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Trae Young").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("34").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
                HStack{
                    Image(home).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                    Text("Malcolm Brogdon").font(.headline).frame(width: geometry.size.width / 1.7, height: geometry.size.width / 10, alignment: .leading)
                    Text("29").fontWeight(.bold).frame(width: geometry.size.width / 5, height: geometry.size.width / 10).font(.title3)
                }
            }
        }
    }
}

struct GameLeaders_Previews: PreviewProvider {
    static var previews: some View {
        GameLeaders()
    }
}

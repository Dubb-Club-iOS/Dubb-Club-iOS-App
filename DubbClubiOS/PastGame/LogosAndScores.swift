//
//  LogosAndScores.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct LogosAndScores: View {
    private var away = "Atlanta Hawks"
    private var home = "Indiana Pacers"
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                ZStack{
                    ColorManager.backgroundGray
                    VStack{
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(away))
                                    .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.imageGray)
                                    .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                                Image(away).resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                            }
                            Text("@").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.title).lineLimit(1).minimumScaleFactor(0.1)
                                .foregroundColor(.white).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: .center)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(home))
                                    .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 2.7)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.imageGray)
                                    .frame(width: geometry.size.width / 2.8, height: geometry.size.width / 2.8)
                                Image(home).resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.9, height: geometry.size.width / 2.9)
                            }
                        }// end of HStack of team logos
                        HStack{
                            Text("110").font(.largeTitle).fontWeight(.bold).frame(width: geometry.size.width / 2.8, height: geometry.size.width / 4)
                            Text("-").font(.largeTitle).frame(width: geometry.size.width / 10, height: geometry.size.width / 10, alignment: .center)
                            Text("104").font(.largeTitle).fontWeight(.bold).frame(width: geometry.size.width / 2.8, height: geometry.size.width / 4)
                        }
                    }
                }
            }
        }
    }
}

struct LogosAndScores_Previews: PreviewProvider {
    static var previews: some View {
        LogosAndScores()
    }
}

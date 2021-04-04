//
//  HomeStreamList.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/3/21.
//

import SwiftUI

struct HomeStreamList: View {
    private var twoColumnGrid = [GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.backgroundGray
                    .ignoresSafeArea()
                
                // Your other content here
                // Other layers will respect the safe area edges
                //            Text("Hello, world!")
                //                .foregroundColor(.white)
                //                .padding()
                VStack(spacing: 0) {
                    HStack {
                        Text("Home").font(.largeTitle).fontWeight(.bold)
                        Spacer()
                    }.padding([.leading, .trailing])
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<10) {_ in
                                PredictionCard(teamName1: "Minnesota Timberwolves", teamName2: "Sacramento Kings").frame(height: geometry.size.height * 0.8)
                                PredictionCard(teamName1: "Utah Jazz", teamName2: "Dallas Mavericks").frame(height: geometry.size.height * 0.8)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeStreamList_Previews: PreviewProvider {
    static var previews: some View {
        HomeStreamList()
    }
}

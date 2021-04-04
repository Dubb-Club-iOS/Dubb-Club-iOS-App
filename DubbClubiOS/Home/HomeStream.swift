//
//  HomeStream.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct HomeStream: View {
    private var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    
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
                        LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                            ForEach(0..<10) {_ in
                                PredictionCard(teamName1: "Minnesota Timberwolves", teamName2: "Sacramento Kings").frame(height: geometry.size.height / 2.2)
                                PredictionCard(teamName1: "Utah Jazz", teamName2: "Dallas Mavericks").frame(height: geometry.size.height / 2.2)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeStream_Previews: PreviewProvider {
    static var previews: some View {
        HomeStream()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                    .previewDisplayName("iPhone 12")

//        HomeStream()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//            .previewDisplayName("iPhone 12 Pro Max")
        
//        HomeStream().previewDevice("iPhone SE (2nd generation)")
    }
}

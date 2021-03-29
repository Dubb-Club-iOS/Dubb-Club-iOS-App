//
//  PredictionCard.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct PredictionCard: View {
    var body: some View {
        
        ZStack {
            ColorManager.cardGray
            VStack {
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Spacer()
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                    Spacer()
                    
                }
                HStack {
                    Spacer()
                    
                    Text("Hi There").font(.system(.title2)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    Spacer()
                    
                    Text("@").font(.system(.largeTitle)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    Spacer()
                    
                    Text("Oh Hey").font(.system(.title2)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    Spacer()
                    
                }
            }
        }
    }
}

struct PredictionCard_Previews: PreviewProvider {
    static var previews: some View {
        PredictionCard()
    }
}

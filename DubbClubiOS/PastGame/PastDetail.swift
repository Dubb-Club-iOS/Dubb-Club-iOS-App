//
//  TeamsAndScores.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PastDetail: View {
    private var away = "Atlanta Hawks"
    private var home = "Indiana Pacers"
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                LogosAndScores().frame(height: geometry.size.height / 2.8)
                ScrollView{
                    VStack{
                        PeriodScores().frame(width: geometry.size.width, height: geometry.size.height / 5)
                        GameLeaders().frame(width: geometry.size.width, height: geometry.size.height / 1.9)
                    }// end of VStack in scroll view
                }// end of scroll view
            }// end of VStack
            
        }// end of geometry
        
    }// end of body
}// end of PastDetail

struct PastDetail_Previews: PreviewProvider {
    static var previews: some View {
        PastDetail()
    }
}

//
//  PastDetail.swift
//  DubbClubiOS
//
//  Created by Batuhan Hakan on 4/21/21.
//

import SwiftUI

struct PastDetail: View {

    @State var gameId: Int
    @State var gameStats: GameStats? = nil
    @ObservedObject var userFaves: UserFaves
    
    func getPastGameDetailsById(gameId: Int) {
        
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGameDetailsByGameId/\(gameId)") {
                let data = try Data(contentsOf: file)
                let stats: GameStats = try! JSONDecoder().decode(GameStats.self, from: data)
                self.gameStats = stats
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    

    var body: some View {
        if self.gameStats == nil {
            ProgressView().onAppear {
                getPastGameDetailsById(gameId: gameId)
            }
        } else {
            GeometryReader { geometry in
                ColorManager.backgroundGray.ignoresSafeArea()
                VStack{
                    ScrollView{
                        VStack{
                            LogosAndScores(game: gameStats!, userFaves: userFaves).frame(height: geometry.size.height / 2.8)
                            PeriodScores(game: gameStats!).frame(width: geometry.size.width, height: geometry.size.height / 5)
                            GameLeaders(game: gameStats!).frame(width: geometry.size.width, height: geometry.size.height / 1.9).padding(.bottom)
                        }// end of VStack in scroll view
                    }// end of scroll view
                }// end of VStack
                .onAppear {
                    getPastGameDetailsById(gameId: self.gameId)
                }
                
            }// end of geometry
        }
        
    }// end of body
}// end of PastDetail


//struct PastDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PastDetail(gameId: 9018)
//    }
//}

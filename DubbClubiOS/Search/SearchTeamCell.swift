//
//  SearchTeamCell.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//

import SwiftUI

struct SearchTeamCell: View {
    var inputTeamId: Int
    @State private var isFollowing = true
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.cardGray
                HStack {
                    // team image
                    /*
                     VStack {
                     Text("Team\nLogo")
                     }
                     .padding(.all, 10)
                     .background(Color.red)
                     */
                    Image(teamIds[inputTeamId]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                        .padding(.all, 10)
                    
                    //team name
                    Text(teamIds[inputTeamId]!)
                    Spacer()
                    
                    if isFollowing {
                        Button(action: {
                            isFollowing = !isFollowing
                        }, label: {
                            Text("Following").foregroundColor(.white)
                                .padding(.all, 8)
                        })
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.trailing, 10)
                    } else {
                        Button(action: {
                            isFollowing = !isFollowing
                        }, label: {
                            Text("Follow").foregroundColor(.blue)
                                .padding(.all, 8)
                        })
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding(.trailing, 10)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.all, 10)
    }
    
}

struct SearchTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchTeamCell(inputTeamId: 2)
    }
}

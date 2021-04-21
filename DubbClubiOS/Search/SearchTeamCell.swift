//
//  SearchTeamCell.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//

import SwiftUI

struct SearchTeamCell: View {
    @Binding var teamId: Int
    @State private var isFollowing = true
    var body: some View {
        HStack {
            // team image
            VStack {
                Text("Team\nLogo")
            }
            .padding(.all, 10)
            .background(Color.red)
            
            //team name
            Text("Team Name")
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
        .background(ColorManager.cardGray)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    
}

struct SearchTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchTeamCell()
    }
}

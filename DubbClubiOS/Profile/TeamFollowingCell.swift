//
//  TeamFollowingCell.swift
//  Dubb Club iOS Designs
//
//  Created by Brandon Lamer-Connolly on 3/29/21.
//

import SwiftUI

struct TeamFollowingCell: View {
    var team: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                // team image
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(teamIds[team]!))
                        .frame(width: geometry.size.width / 4.7, height: geometry.size.width / 4.7, alignment: .leading)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(ColorManager.imageGray)
                        .frame(width: geometry.size.width / 4.8, height: geometry.size.width / 4.8)
                    Image(teamIds[team]!).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 4.9, height: geometry.size.width / 4.9)
                }
                
                //team name
                Text(teamIds[team]!).fontWeight(.bold).font(.title2)
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "star.fill").foregroundColor(.blue).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }).padding(.trailing)
                
//                Button(action: {}, label: {
//                    Text("Following").foregroundColor(.white)
//                        .padding(.all, 8)
//                })
//                .background(Color.blue)
//                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                .padding(.trailing, 10)
            }
            .background(ColorManager.cardGray)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

        }
    }
}

struct TeamFollowingCell_Previews: PreviewProvider {
    static var previews: some View {
        TeamFollowingCell_PreviewWrapper()
    }
    struct TeamFollowingCell_PreviewWrapper: View {
//        @StateObject var userFaves = UserFaves()
        var body: some View {
            TeamFollowingCell(team: 1)
        }
    }
}

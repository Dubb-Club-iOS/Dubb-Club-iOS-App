//
//  TeamFollowingCell.swift
//  Dubb Club iOS Designs
//
//  Created by Brandon Lamer-Connolly on 3/29/21.
//

import SwiftUI

struct TeamFollowingCell: View {
    var body: some View {
        HStack {
            VStack {
                Text("Team\nLogo")
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
            .background(Color.red)
            Text("Team Name")
            Spacer()
            Button(action: {}, label: {
                Text("Following").foregroundColor(.white)
                    .padding(.all, 8)
            })
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.trailing, 10)
        }
        .background(ColorManager.cardGray)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
}

struct TeamFollowingCell_Previews: PreviewProvider {
    static var previews: some View {
        TeamFollowingCell()
    }
}

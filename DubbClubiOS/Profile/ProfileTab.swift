//
//  ProfileTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/31/21.
//

import SwiftUI

struct ProfileTab: View {
    var body: some View {
        NavigationView {
            /*
             NavigationLink(destination: Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate") }
             */
            ScrollView {
                VStack {
                    /*
                     HStack{
                     Text("Profile")
                     .font(.system(size: 34))
                     .fontWeight(.heavy)
                     .padding([.top, .leading], 10.0)
                     Spacer()
                     }
                     */
                    Image("DubbClub Logo")
                        .resizable()
                        .frame(width: 865/5, height: 868/5, alignment: .center)
                    Text("@exampleUsername")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.all, 20)
                        .frame(width: 300, height: 50)
                    HStack {
                        Text("Teams Following:")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    TeamsFollowingList()
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}

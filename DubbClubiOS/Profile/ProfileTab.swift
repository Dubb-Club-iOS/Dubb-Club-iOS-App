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
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
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
                        .padding(.all)
                        .frame(width: 865/4, height: 868/4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("@exampleUsername")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.all, 20)
                        .frame(width: 210, height: 90)
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

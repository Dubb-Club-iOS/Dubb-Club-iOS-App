//
//  ProfileTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/31/21.
//

import SwiftUI

struct ProfileTab: View {

    let darkMode: Color = Color("Background Gray")
    var body: some View {
        NavigationView {
            /*
             NavigationLink(destination: Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate") }
             */
            ZStack {
                ColorManager.backgroundGray.ignoresSafeArea()
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
                        NavigationLink(destination: LoginUIView()) {
                            Text("Log Out")
                        }.simultaneousGesture(TapGesture().onEnded{
                            self.logout()
                        })
                    }
                    
                    
                }
                .navigationTitle("Profile")
            }
        }
    }
    func logout() {
        print("LOGOUT")
        UserDefaults.standard.set(nil, forKey:"JWT")
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}

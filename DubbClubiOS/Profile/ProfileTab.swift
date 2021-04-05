//
//  ProfileTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/31/21.
//

import SwiftUI

struct ProfileTab: View {
    
    @State var selection: Int? = 1
    
    func logout() {
        print("LOGOUT")
        UserDefaults.standard.set(nil, forKey:"JWT")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("@exampleUsername")
                    .fontWeight(.bold)
                Spacer()
                Text("Teams Following:")
                TeamsFollowingList()
                
                NavigationLink(destination: LoginUIView()) {
                    Text("Log Out")
                }.simultaneousGesture(TapGesture().onEnded{
                    self.logout()
                })
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}

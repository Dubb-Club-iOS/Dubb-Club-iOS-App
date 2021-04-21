//
//  ProfileTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 3/31/21.
//

import SwiftUI

struct ProfileTab: View {
    @Binding var isLoggedIn: Bool
    @Binding var upcomingGames: [UpcomingGame]

    var body: some View {
        NavigationView {
            /*
            .navigationTitle("Profile")
            .navigationBarItems(trailing: {
                Button(action: {
                    NavigationLink(destination: LoginUIView()) {
                        Text("Log Out")
                    }.simultaneousGesture(TapGesture().onEnded{
                        self.logout()
                    })
                }, label: {
                    Text("Logout").foregroundColor(.white)
                        .padding(.all, 8)
                })
            })
            */
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
                        Image("DubbClub Logo PNG")
                            .resizable()
                            .frame(width: 865/4.5, height: 868/4.5, alignment: .center)
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

                        /*
                        

//                        NavigationLink(destination: LoginUIView(isLoggedIn: $isLoggedIn)) {
//                            Text("Log Out")
//                        }.simultaneousGesture(TapGesture().onEnded{
//                            self.logout()
//                        })
                        Button(action: {self.logout()}, label: {

                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(Color.blue)
                                .padding()
                        })

                        */
                    }
                    
                    

                }.navigationTitle("Profile").navigationBarItems(trailing:
                        NavigationLink(destination: LoginUIView(isLoggedIn: $isLoggedIn, upcomingGames: $upcomingGames)) {
                            Button(action:  {self.logout()}, label: {
                                Text("Log Out").foregroundColor(.white)
                            })

                        }.simultaneousGesture(TapGesture().onEnded{
                           
                        })

                )
                    

            }
        }.navigationBarBackButtonHidden(true)
        
    }
    func logout() {
        UserDefaults.standard.set(nil, forKey:"JWT")
        self.isLoggedIn = false
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab_PreviewWrapper()
    }
    struct ProfileTab_PreviewWrapper: View {
        @State var games = getUpcomingGames()
        @State var isLoggedIn = true
        var body: some View {
            ProfileTab(isLoggedIn: $isLoggedIn, upcomingGames: $games)
        }
    }
}

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
    @ObservedObject var userFaves: UserFaves
    
    @State var showingPopover = false
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
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
                            Text("@\(UserDefaults.standard.object(forKey: "Username") as! String)")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .padding(.all, 20)
                                .frame(width: 300, height: 50)
                            
                            
                            
                            if userFaves.nba.count == 0 {
                                Text("It doesn't look like you have any favorite teams...")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10)
                            } else {
                                HStack {
                                    Text("Favorite Teams:")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 10)
                                    Spacer()
                                }
                                
                                ForEach(userFaves.nba, id: \.self) { team in
                                    HStack() {
                                        // team image
                                        TeamFollowingButton(team: team, userFaves: userFaves, parentGeo: geometry)
                                        Button(action: {
                                            unfollowTeam(teamId: team)
                                        }, label: {
                                            Image(systemName: "star.fill").foregroundColor(.blue).font(.title)
                                        }).padding(.trailing)
                                        
                                    }

                                    .background(ColorManager.cardGray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                }.onDelete(perform: { indexSet in
                                    print("hi")
                                })
                            }
                            
                        }
                        
                        
                        
                    }.navigationTitle("Profile").navigationBarItems(trailing: NavigationLink(destination: LoginUIView(isLoggedIn: $isLoggedIn, upcomingGames: $upcomingGames, userFaves: userFaves)) {
                        Button(action:  {self.logout()}, label: {
                            Text("Log Out").foregroundColor(.white)
                        })
                        
                    }.simultaneousGesture(TapGesture().onEnded{
                        
                    })
                    
                    )
                    
                    
                }
            }.navigationBarBackButtonHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    func logout() {
        UserDefaults.standard.set(nil, forKey:"JWT")
        self.isLoggedIn = false
    }
    
    func unfollowTeam(teamId: Int) {
        withAnimation(.spring()){
            userFaves.nba.removeAll { team in
                team == teamId
            }
        }
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/unfavoriteteam", teamId: teamId)
    }
    
}


struct TeamFollowingButton: View {
    var team: Int
    @ObservedObject var userFaves: UserFaves
    var parentGeo: GeometryProxy
    @State var showingPopover = false
    
    
    var body: some View {
        
        Button(action: {
            self.showingPopover = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(teamIds[team]!))
                    .frame(width: parentGeo.size.width / 4.7, height: parentGeo.size.width / 4.7, alignment: .leading)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(ColorManager.imageGray)
                    .frame(width: parentGeo.size.width / 4.8, height: parentGeo.size.width / 4.8)
                Image(teamIds[team]!).resizable()
                    .scaledToFit()
                    .frame(width: parentGeo.size.width / 4.9, height: parentGeo.size.width / 4.9)
            }
            
            //team name
            Text(teamIds[team]!).fontWeight(.regular).font(.title3)
            Spacer()
        }.popover(isPresented: $showingPopover) {
            TeamDetail(userFaves: userFaves, teamId: team)
        }
        
        
    }
    
    func unfollowTeam(teamId: Int) {
        withAnimation(.spring()){
            userFaves.nba.removeAll { team in
                team == teamId
            }
        }
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/unfavoriteteam", teamId: teamId)
    }
}



struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab_PreviewWrapper()
    }
    struct ProfileTab_PreviewWrapper: View {
        @State var games = getUpcomingGames()
        @State var isLoggedIn = true
        @StateObject var userFaves = UserFaves(nba: [1])
        var body: some View {
            ProfileTab(isLoggedIn: $isLoggedIn, upcomingGames: $games, userFaves: userFaves)
        }
    }
}

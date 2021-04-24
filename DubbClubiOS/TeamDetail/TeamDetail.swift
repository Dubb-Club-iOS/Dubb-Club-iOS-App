//
//  TeamDetail.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 4/22/21.
//

import SwiftUI

struct TeamDetail: View {
    
    @ObservedObject var userFaves: UserFaves
    @State var team: Team
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var columns: [GridItem] =
        [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    init(userFaves: UserFaves, teamId: Int) {
        let allTeams = Array(getTeams().joined())
        let match = allTeams.first(where: { $0.teamId == teamId })
        _team = State(initialValue: match!)
        self.userFaves = userFaves
    }
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ColorManager.backgroundGray
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.down").font(Font.title2.weight(.semibold)).padding()
                            
                        }
                        Spacer()
                        if userFaves.nba.contains(team.teamId) {
                            Button(action: {
                                unfollowTeam(teamId: team.teamId)
                            }) {
                                Image(systemName: "star.fill").font(.title).foregroundColor(.yellow)
                                    .padding()
                                
                            }
                        } else {
                            Button(action: {
                                followTeam(teamId: team.teamId)
                            }) {
                                Image(systemName: "star").font(.title).foregroundColor(.yellow)
                                    .padding()
                                
                            }
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(teamIds[team.teamId]!))
                            .frame(width: geometry.size.width / 2.2, height: geometry.size.width / 2.2)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(ColorManager.imageGray)
                            .frame(width: geometry.size.width / 2.3, height: geometry.size.width / 2.3)
                        Image(teamIds[team.teamId]!).resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 2.4, height: geometry.size.width / 2.4)
                    }
                    HStack {
                        Text(team.teamName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.largeTitle).multilineTextAlignment(.center)
                        //                        Image(systemName: "star.fill").foregroundColor(.blue).font(.largeTitle)
                    }.padding()
                    
                    VStack {
                    if team.conference == "east" {
                        Text("Eastern Conference").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title).padding(.top, 10)
                    } else {
                        Text("Western Conference").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title2).padding(.top, 10)
                    }
                    
                    Text("#\(team.standing)").fontWeight(.semibold).font(.title2).padding(.bottom, 10)
                        
                    }
                    .frame(width: geometry.size.width)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.cardGray)).padding([])
                    
                   
                    LazyVGrid(columns: columns, spacing: 16) {
                        Section {
                            Text("Wins").fontWeight(.semibold).font(.title)
                            Text("Losses").fontWeight(.semibold).font(.title)
                            Text("GB").fontWeight(.semibold).font(.title)
                        }.padding(.top)
                        Text("\(team.wins)").fontWeight(.semibold).font(.title2)
                        Text("\(team.losses)").fontWeight(.semibold).font(.title2)
                        Text("\(team.gamesBehind, specifier: "%0.0f")")
                            .fontWeight(.semibold).font(.title2)
                        Spacer()
                        Section {
                            Text("L10").fontWeight(.semibold).font(.title)
                            Text("Streak").fontWeight(.semibold).font(.title)
                            Text("Elo").fontWeight(.semibold).font(.title)
                        }
                        Text("\(team.lastTenWins)-\(team.lastTenLosses)").fontWeight(.semibold).font(.title2)
                        Text("\(team.winStreak)").fontWeight(.semibold).font(.title2)
                        Text("\(team.elo, specifier: "%0.2f")").fontWeight(.semibold).font(.title2)
                    }
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(ColorManager.cardGray))
                    
                    
                    
                    Spacer()
                    
                }
            }.navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func followTeam(teamId: Int) {
        withAnimation(){
            userFaves.nba.append(teamId)
        }
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/favoriteteam", teamId: teamId)
    }
    func unfollowTeam(teamId: Int) {
        withAnimation(){
            userFaves.nba.removeAll { team in
                team == teamId
            }
        }
        followTeamFunc(urlStr: "https://api.dubb.club/api/user/unfavoriteteam", teamId: teamId)
    }
    
}

struct TeamDetail_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetail_PreviewWrapper()
    }
    struct TeamDetail_PreviewWrapper: View {
        @StateObject var userFaves = UserFaves(nba: [4, 22])
        var body: some View {
            TeamDetail(userFaves: userFaves, teamId: 16)
        }
    }
}

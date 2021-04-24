//
//  SwiftUIView.swift
//  DubbClubiOS
//
//  Created by Aditya Naik on 4/19/21.
//

import SwiftUI

struct Standings: View {
    
    @State var eastStandings = [Team]()
    @State var westStandings = [Team]()
    @State var hasLoaded = false
    @State private var width: CGFloat? = nil
    @ObservedObject var userFaves: UserFaves
        
    var columns: [GridItem] =
        [
            GridItem(.flexible()),
            GridItem(.flexible(minimum: 190), alignment: .leading),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    var body: some View {
        //        if !self.hasLoaded {
        //            ProgressView()
        //        } else {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    ColorManager.backgroundGray
                        .ignoresSafeArea()
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            Section(header: Text("EAST")
                                        .font(.title)
                                        .bold()
                                        .padding(.top, 30)
                            ) {
                                Text("")
                                Text("Team").bold()
                                Text("W").bold()
                                Text("L").bold()
                                Text("GB").bold()
                                ForEach(self.eastStandings, id: \.self) { team in
                                    StandingsLink(team: team, userFaves: userFaves)
                                        .frame(width: geometry.size.width / 12, height: geometry.size.width / 12)
                                    Text(team.teamName)
                                    Text("\(team.wins)")
                                    Text("\(team.losses)")
                                    Text("\(Int(team.gamesBehind))")
                                }
                            }
                            Section(header: Text("WEST")
                                        .font(.title)
                                        .bold()
                                        .padding(.top, 30)
                                        .frame(alignment: .leading)
                            ) {
                                Text("")
                                Text("Team").bold()
                                Text("W").bold()
                                Text("L").bold()
                                Text("GB").bold()
                                ForEach(self.westStandings, id: \.self) { team in
                                    StandingsLink(team: team, userFaves: userFaves)
                                        .frame(width: geometry.size.width / 12, height: geometry.size.width / 12)
                                    Text(team.teamName)
                                    Text("\(team.wins)")
                                    Text("\(team.losses)")
                                    Text("\(Int(team.gamesBehind))")
                                }
                            }
                        }
                        .padding(.trailing, 10)
                        .padding(.bottom, 20)
                    }.navigationBarTitle(Text("Standings"))
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
    
}

struct Standings_Previews: PreviewProvider {
    static var previews: some View {
        Standings_PreviewWrapper()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
    }
    struct Standings_PreviewWrapper: View {
        @State var allTeams = getTeams()
        @StateObject var userFaves = UserFaves(nba: [1, 22])
        
        var body: some View {
            Standings(eastStandings: allTeams[0], westStandings: allTeams[1], userFaves: userFaves)
        }
    }
}

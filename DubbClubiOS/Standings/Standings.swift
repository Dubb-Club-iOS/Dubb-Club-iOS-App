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
    
    func getTeams() {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getTeamsFromDb") {
                let data = try Data(contentsOf: file)
                let teamStandings: [Team] = try! JSONDecoder().decode([Team].self, from: data)
                for team in teamStandings {
                    if team.conference == "east" {
                        self.eastStandings.append(team)
                    } else {
                        self.westStandings.append(team)
                    }
                }
                self.eastStandings = self.eastStandings.sorted(by: { $0.standing < $1.standing })
                self.westStandings = self.westStandings.sorted(by: { $0.standing < $1.standing })
                self.hasLoaded = true
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    //                            Image(teamIds[game.away[0].teamId]!).resizable().scaledToFit()
    var columns: [GridItem] =
        [
            GridItem(.flexible()),
            GridItem(.flexible(minimum: 200), alignment: .leading),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
    var body: some View {
        if !self.hasLoaded {
            ProgressView().onAppear {
                getTeams()
            }
        } else {
            GeometryReader { geometry in
                NavigationView {
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
                                    Image(team.teamName)
                                        .resizable()
                                        .scaledToFit()
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
                                    Image(team.teamName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width / 12, height: geometry.size.width / 12)
                                    Text(team.teamName)
                                    Text("\(team.wins)")
                                    Text("\(team.losses)")
                                    Text("\(Int(team.gamesBehind))")
                                }
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }.navigationBarTitle(Text("Standings"))
                }
            }
        }
    }
}

struct Standings_Previews: PreviewProvider {
    static var previews: some View {
        Standings()
    }
}

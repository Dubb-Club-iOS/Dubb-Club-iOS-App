//
//  SearchTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//

import SwiftUI






struct SearchTab: View {
    
    @State var gameIds = [Int]()
    @State var gameObjs = [GameFromDb]()
    @State private var searchBy = 0 // could be search by team or search by date
    @State var searchInput: String = ""
    @State private var isEditing = false
    @State private var animate = false
    @State private var searchMatchesTeam = -1
    @Binding private var upcomingGames = [UpcomingGame]()
    @Binding private var pastGames = [PastGameForTeam]()
    private var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    
    func getGames() {
        if searchBy == 0 {
            var inputtedTeam: String = searchInput
            searchMatchesTeam = searchTeamNamesArray(input: inputtedTeam)
            
            if searchMatchesTeam == 1 {
                let teamSearchedFor: Int = findTeamId(input: inputtedTeam)
                
                getGameIdsForTeam(teamId: teamSearchedFor)
                //gameIds should have all the info we need
                
                for game in gameIds {
                    getGameById(gameId: game)
                }
                
                
                
            } else {
                Text("No results found :(")
            }
            
            //TeamFollowingCell()
            LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                
                 ForEach(upcomingGames, id: \.self) { game in
                 PredictionCard(game: game).frame(height: geometry.size.height / 2.2)
                 
                 }
                 
            }
        } else {
            
        }
    }
    
    func searchTeamNamesArray(input: String) -> Int {
        let allPossibleResults = searchTeamName
        let inputTrimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        for result in allPossibleResults {
            if inputTrimmed.caseInsensitiveCompare(result.key) == ComparisonResult.orderedSame {
                return 1
            }
        }
        return -1
    }

    func findTeamId(input:String) -> Int {
        let allPossibleResults = searchTeamName
        let inputTrimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        for result in allPossibleResults {
            if inputTrimmed.caseInsensitiveCompare(result.key) == ComparisonResult.orderedSame {
                return result.value
            }
        }
        return -1
    }
    
    func getGameIdsForTeam(teamId: Int) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGamesByTeamFromDb/\(teamId)") {
                let data = try Data(contentsOf: file)
                let gameIds: [Int] = try! JSONDecoder().decode([Int].self, from: data)
                self.gameIds = gameIds
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameIdsForDate(date: String) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGamesByDateFromDb/\(date)") {
                let data = try Data(contentsOf: file)
                let gameIds: [Int] = try! JSONDecoder().decode([Int].self, from: data)
                self.gameIds = gameIds
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getGameById(gameId: Int) {
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getGameFromDb/\(gameId)") {
                let data = try Data(contentsOf: file)
                print(gameId)
                let game: GameFromDbParent = try! JSONDecoder().decode(GameFromDbParent.self, from: data)
                self.gameObjs.append(game.game)
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            /*
             NavigationLink(destination: Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate") }
             */
            GeometryReader { geometry in
                ZStack {
                    ColorManager.backgroundGray.ignoresSafeArea()
                    ScrollView {
                        VStack {
                            Picker(selection: $searchBy, label: Text("SearchFilter")) {
                                Text("Team").tag(0)
                                Text("Date").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.all, 10)
                            
                            HStack {
                                if searchBy == 0 {
                                    TextField("Search...", text: $searchInput)
                                        .onAppear(perform: {
                                            self.animate = true
                                        })
                                        .padding(7)
                                        .padding(.horizontal, 25)
                                        .background(Color(.systemGray4))
                                        .cornerRadius(8)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            self.isEditing = true
                                        }
                                    if searchInput.count != 0 {
                                        Button(action: {
                                            self.isEditing = false
                                            self.searchInput = ""
                                            
                                        }) {
                                            Text("Cancel")
                                        }
                                        .padding(.trailing, 10)
                                        .transition(.move(edge: .trailing))
                                        //.animation(.easeInOut)
                                        .animation(.easeInOut)
                                    }
                                } else {
                                    DatePicker(selection: .constant(Date()), displayedComponents: [.date], label: { Text("Game Date") })
                                        .padding(7)
                                        .padding(.horizontal, 25)
                                        .background(Color(.systemGray4))
                                        .cornerRadius(8)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            self.isEditing = true
                                        }
                                    /*
                                     if searchInput.count != 0 {
                                     Button(action: {
                                     self.isEditing = false
                                     self.searchInput = ""
                                     
                                     }) {
                                     Text("Cancel")
                                     }
                                     .padding(.trailing, 10)
                                     .transition(.move(edge: .trailing))
                                     //.animation(.easeInOut)
                                     .animation(.easeInOut)
                                     }
                                     */
                                }
                            }
                            .maybe(animate) { content in
                                content.animation(.easeInOut)
                            }
                            
                    
                            
                        }
                    }
                }
                .navigationTitle("Search")
            }
        }
    }
}

struct SearchTab_Previews: PreviewProvider {
    //let example: Binding<String> = "lakers"
    static var previews: some View {
        SearchTab()
    }
}

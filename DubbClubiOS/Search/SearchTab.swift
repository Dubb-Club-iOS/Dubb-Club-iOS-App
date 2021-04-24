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
    @State var searchBy = 0 // could be search by team or search by date
    @State var searchInput: String = ""
    @State var searchOutput: String = ""
    @State var datePicked = Date()
    @State var isEditing = false
    @State private var animate = false
    @State private var searchMatchesTeam = -1
    var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
    @State var upcomingGames = [UpcomingGame]()
    @State var pastGames = [PastGameForTeam]()
    
    func getDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let UTCDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM/dd 'at' h:mm a" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
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
    func reset() {
        self.gameIds = [Int]()
        self.gameObjs = [GameFromDb]()
        self.upcomingGames = [UpcomingGame]()
        self.pastGames = [PastGameForTeam]()
    }
    
    func getGamesForTeam(teamId: Int) {
        getGameIdsForTeam(teamId: teamId)
        for gameId in gameIds {
            getGameById(gameId: gameId)
        }
    }
    
    func getUpcomingGamesFromGameList() {
        /*
         let now = Date()
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         
         //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
         let datetime = formatter.string(from: now)
         
         let nowFormatted = getDate(date: datetime)
         print(nowFormatted)
         */
        for game in gameObjs {
            /*
             let gameDate = game.date
             print(datetime.compare(gameDate, options: .caseInsensitive))
             if datetime.compare(gameDate, options: .caseInsensitive) != .orderedDescending {
             let gameToAdd = DubbClubiOS.UpcomingGame(confidence: game.confidence, away: game.away, home: game.home, predictedWinner: game.predictedWinner, status: game.status, id: game.id, date: game.date)
             self.upcomingGames.append(gameToAdd)
             }
             */
            if game.status != "Finished" {
                let gameToAdd = DubbClubiOS.UpcomingGame(confidence: game.confidence, away: game.away, home: game.home, predictedWinner: game.predictedWinner, status: game.status, id: game.id, date: game.date)
                self.upcomingGames.append(gameToAdd)
            }
            
        }
        print(self.upcomingGames.count)
    }
    
    func getPastGamesFromGameList() {
        /*
         let now = Date()
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         
         //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
         let datetime = formatter.string(from: now)
         
         let nowFormatted = getDate(date: datetime)
         print(nowFormatted)
         */
        for game in gameObjs {
            /*
             let gameDate = game.date
             print(datetime.compare(gameDate, options: .caseInsensitive))
             if datetime.compare(gameDate, options: .caseInsensitive) == .orderedDescending {
             let gameToAdd = DubbClubiOS.PastGameForTeam(gameId: String(game.id), date: game.date, home: game.home[0], away: game.away[0], gameStats: game.playedGameStats!)
             self.pastGames.append(gameToAdd)
             }
             */
            if game.status == "Finished" {
                let gameToAdd = DubbClubiOS.PastGameForTeam(gameId: String(game.id), date: game.date, home: game.home[0], away: game.away[0], gameStats: game.playedGameStats!)
                self.pastGames.append(gameToAdd)
            }
        }
        print(self.pastGames.count)
    }
    
    
    
    func searchTeamNamesArray(input: String) -> Int {
        let allPossibleResults = searchTeamName
        let inputTrimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        for (name, id) in allPossibleResults {
            if inputTrimmed.caseInsensitiveCompare(name) == ComparisonResult.orderedSame {
                return id
                
            }
        }
        return -1
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                /*
                 NavigationLink(destination: Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate") }
                 */
                
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
                                    TextField("Search...", text: $searchInput, onEditingChanged: { (edit) in
                                        self.isEditing = true
                                    }, onCommit: {
                                        self.isEditing = false
                                        self.searchOutput = self.searchInput
                                        self.searchMatchesTeam = searchTeamNamesArray(input: searchOutput)
                                        getGamesForTeam(teamId: searchMatchesTeam)
                                        getUpcomingGamesFromGameList()
                                        getPastGamesFromGameList()
                                        print("committed!")
                                        print(searchInput)
                                        print(searchMatchesTeam)
                                    })
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
                                            self.searchOutput = ""
                                            reset()
                                            
                                        }) {
                                            Text("Cancel")
                                        }
                                        .padding(.trailing, 10)
                                        .transition(.move(edge: .trailing))
                                        //.animation(.easeInOut)
                                        .animation(.easeInOut)
                                    }
                                } else {
                                    DatePicker(selection: $datePicked, displayedComponents: [.date], label: { Text("Game Date") })
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
                        
                        LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                            ForEach(upcomingGames, id: \.self) { gameItem in
                                SearchUpcomingGameCell(game: gameItem)
                                    .frame(height: geometry.size.height / 2.5)
                                    .cornerRadius(10)
                                    .aspectRatio(1, contentMode: .fit)

                            }
                            ForEach(pastGames, id: \.self) { gameItem in
                                SearchPastGameCell(game: gameItem)
                                    .frame(height: geometry.size.height / 2.5)
                                    .cornerRadius(10)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            
                        }
                        
                        //                        if searchBy == 0 {
                        //                            if searchOutput.count > 0 {
                        //                                if searchMatchesTeam != -1 {
                        //                                    SearchTeamResultCells(inputTeamId: searchMatchesTeam)
                        //                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        //                                }
                        //                            }
                        //
                        //                        } else {
                        //                            SearchDateResultCells(inputDate: datePicked)
                        //                        }
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

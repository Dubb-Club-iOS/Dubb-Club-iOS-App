//
//  ContentView.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/22/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var standings = [TeamStanding]()
    
    func getStandingsFromDb() {
        
        /*
         To make a request...
         
         The base URL is https://api.dubb.club/api/nba, to which you can add extensions such as the one
         below or others in the README in Google Drive.
         
         When you make a request, you also need to make a "model" to handle the request JSON. This is in the file Model.swift.
         The JSONDecoder() like will populate this object with the field specified. Also, if there are nested objects, those will need
         to also be models. It's tedious but I couldn't fina another way to do it.
         */
        
        do {
            if let file = URL(string: "https://api.dubb.club/api/nba/getTeamStandings") {
                let data = try Data(contentsOf: file)
                let teamStandings: TeamStandings = try! JSONDecoder().decode(TeamStandings.self, from: data)
                let teamsArr = teamStandings.teams
                self.standings = teamsArr
                
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        // Temp UI
        List(standings, id: \.teamId) { item in
            VStack(alignment: .leading) {
                Text(item.getStandingAsStr())
            }
        }.onAppear(perform: getStandingsFromDb)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SearchTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//

import SwiftUI

struct SearchTab: View {
    @State private var searchBy = 0 // could be search by team or search by date
    var teamName: String
    
    var body: some View {
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
                        
                        if (searchBy == 0) {
                            TextField("Search by Team", text: teamName)
                                .padding(7)
                                .padding(.horizontal, 25)
                                .background(Color.blue)
                        }
                    }
                    
                    
                }
                .navigationTitle("Search")
            }
        }
    }
}

struct SearchTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchTab()
    }
}

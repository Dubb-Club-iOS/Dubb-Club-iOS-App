//
//  SearchTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//

import SwiftUI

struct SearchTab: View {
    @State private var searchBy = 0 // could be search by team or search by date
    @State var searchInput: String = ""
    @State private var isEditing = false
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
                        /*
                        var searchPlaceholder: String
                        if (searchBy == 0) {
                            searchPlaceholder = "Search by Team"
                        } else {
                            searchPlaceholder = "Search by Date"
                        }
                        */
                        HStack {
                            if searchBy == 0 {
                                TextField("Search...", text: $searchInput)
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
                        }.animation(.easeInOut)
                            
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
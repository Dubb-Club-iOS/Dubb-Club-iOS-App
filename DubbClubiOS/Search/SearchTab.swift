//
//  SearchTab.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/5/21.
//
//  Code and implementation found on https://www.avanderlee.com/swiftui/withanimation-completion-callback/ for animation completion code


import SwiftUI


/// An animatable modifier that is used for observing animations for a given animatable value.
struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {

    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value

    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }

        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }

    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

struct SearchTab: View {
    @State private var searchBy = 0 // could be search by team or search by date
    @State var searchInput: String = ""
    @State private var isEditing = false
    @State private var firstOpen = true
    @State private var upcomingGames = [UpcomingGame]()
    //@State private var pastGames = 
    private var twoColumnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
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
                            
                            VStack {
                                if searchBy == 0 {
                                    TeamFollowingCell()
                                }
                                LazyVGrid(columns: twoColumnGrid, spacing: 4) {
                                    /*
                                    ForEach(upcomingGames, id: \.self) { game in
                                        PredictionCard(game: game).frame(height: geometry.size.height / 2.2)
                                        
                                    }
                                    */
                                }
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

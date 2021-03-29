//
//  HomeStream.swift
//  DubbClubiOS
//
//  Created by Chris Koehne on 3/29/21.
//

import SwiftUI

struct HomeStream: View {
    var body: some View {
        ZStack {
            ColorManager.backgroundGray
                .ignoresSafeArea()
            
            // Your other content here
            // Other layers will respect the safe area edges
            Text("Hello, world!")
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct HomeStream_Previews: PreviewProvider {
    static var previews: some View {
        HomeStream()
    }
}

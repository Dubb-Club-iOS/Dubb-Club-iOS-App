//
//  SearchBarAnimationUtility.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/14/21.


import Foundation
import SwiftUI

extension View {
   @ViewBuilder
   func `maybe`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}


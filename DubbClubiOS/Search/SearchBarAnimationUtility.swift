//
//  SearchBarAnimationUtility.swift
//  DubbClubiOS
//
//  Created by Brandon Lamer-Connolly on 4/14/21.
//  Code and implementation found on https://www.avanderlee.com/swiftui/withanimation-completion-callback/


import Foundation
import SwiftUI

extension View {

    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}

//
//  SpringToTop.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import Foundation

import SwiftUI

struct SpringToTopModifier: ViewModifier {
    let offset: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(offset == 0 ? 1 : 0)
            .offset(y: offset)
            .animation(
                .default,
                value: offset
            )
    }
}

struct FadeModifier: ViewModifier {
    let duration: Double
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .animation(.easeInOut(duration: duration), value: opacity)
    }
}

extension AnyTransition {
    static var springToTop: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: SpringToTopModifier(offset: 12),
                identity: SpringToTopModifier(offset: 0)
            ),
            removal: .modifier(
                active: FadeModifier(duration: 0.1, opacity: 0),
                identity: FadeModifier(duration: 0.1, opacity: 1)
            )
        )
    }
}

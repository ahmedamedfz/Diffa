//
//  ddiffaApp.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 25/04/23.
//

import SwiftUI

@main
struct ddiffaApp: App {
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                ContentView()
                    .preferredColorScheme(.dark)
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

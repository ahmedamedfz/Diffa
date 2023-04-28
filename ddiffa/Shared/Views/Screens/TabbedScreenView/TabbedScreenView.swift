//
//  TabbedScreenView.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import SwiftUI


struct TabbedScreenView: View {
    
    enum AppTab: Equatable {
        case pomodoro, stretching, profile
    }
    
    @State private var activeTab: AppTab = .pomodoro
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.background.translucent)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "text-quaternary")
    }
    
    var body: some View {
        TabView(selection: $activeTab) {
            PomodoroNotStartedScreenView()
                .tabItem {
                    Image(systemName: activeTab == .pomodoro ? "clock.fill" : "clock")
                        .environment(\.symbolVariants, .none)
                }
                .tag(AppTab.pomodoro)
            
            Text("TODO: stretching")
                .tabItem {
                    Image(systemName: activeTab == .stretching ? "dumbbell.fill" : "dumbbell")
                        .environment(\.symbolVariants, .none)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.background.base, for: .tabBar)
                .tag(AppTab.stretching)
            
            VStack {
                Text("Debug helper:")
                Button {
                    UserDefaults.standard.set(false, forKey: UserDefaults.keyHasFinishedOnboarding)
                } label: {
                    Text("Reset onboarding")
                }
                Text("You need to change the app for the changes to take effect")
            }
                .tabItem {
                    Image(systemName: activeTab == .profile ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                        .tint(.red)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.background.base, for: .tabBar)
                .tag(AppTab.profile)
        }
    }
}

struct TabbedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedScreenView()
            .preferredColorScheme(.dark)
    }
}

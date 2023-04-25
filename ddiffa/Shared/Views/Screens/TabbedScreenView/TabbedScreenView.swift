//
//  TabbedScreenView.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import SwiftUI


struct TabbedScreenView: View {
    
    enum AppTab {
        case pomodoro, stretching, settings
    }
    
    @State private var activeTab: AppTab = .pomodoro
    
    var body: some View {
        TabView(selection: $activeTab) {
            Text("TODO: pomodoro")
                .tabItem {
                    Text("pomodoro")
                }
                .tag(AppTab.pomodoro)
            
            Text("TODO: stretching")
                .tabItem {
                    Text("stretching")
                }
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
                    Text("profile")
                }
                .tag(AppTab.settings)
        }
    }
}

struct TabbedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedScreenView()
    }
}

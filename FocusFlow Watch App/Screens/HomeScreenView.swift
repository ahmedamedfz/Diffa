//
//  HomeScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct HomeScreenView: View {
    
    enum Tab {
        case pomodoro, stretching
    }
    
    @State var selectedTab: Tab = .pomodoro
    
    var body: some View {
        TabView {
            PomodoroNotStartedView()
                .tag(Tab.pomodoro)
            
            StretchingMainScreenView()
                .tag(Tab.stretching)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(WatchPreviewFactory().makeSessionManager())
            .environmentObject(MainViewModel())
    }
}

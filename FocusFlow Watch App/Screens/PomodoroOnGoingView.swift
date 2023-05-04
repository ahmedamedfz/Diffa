//
//  PomodoroOnGoingView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI
import CoreData

struct PomodoroOnGoingView: View {
    
    enum Tab {
        case controls, session, nowPlaying
    }
//    @Environment(\.managedObjectContext) var viewContext
    
    @EnvironmentObject var sessionManager: PomodoroSessionManager
    
    @State var selectedTab: Tab = .session
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("TODO: Controls Screen").tag(Tab.controls)
            
            PomodoroScreenView()
            .tag(Tab.session)
            
            Text("TODO: Now Playing Screen").tag(Tab.nowPlaying)
        }
    }
}

struct PomodoroOnGoingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let sessionManager = PomodoroSessionManager.shared
        
        return PomodoroOnGoingView()
            .environment(\.managedObjectContext, context)
            .environmentObject(sessionManager)
    }
}

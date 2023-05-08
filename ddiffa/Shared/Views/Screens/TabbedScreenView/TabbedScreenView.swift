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
            
            StretchingScroll()
                .tabItem {
                    Image(systemName: activeTab == .stretching ? "dumbbell.fill" : "dumbbell")
                        .environment(\.symbolVariants, .none)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.background.base, for: .tabBar)
                .tag(AppTab.stretching)
            
            AnalyticsView()
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
    }
}

// TODO: Delete
struct DebugCoreData: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.startTime)
    ]) var lastPomodoroSessions: FetchedResults<Pomodoro>
    
    let pomodoroSessionPersistence: PomodoroSessionPersistence
    
    init() {
        self.pomodoroSessionPersistence = PomodoroSessionPersistence.shared
    }
    
    func createMockCoreData() {
        let mock1 = pomodoroSessionPersistence.createNewSession(in: managedObjectContext)
        let project1 = Project(context: managedObjectContext)
        let tag1 = Tag(context: managedObjectContext)
        tag1.name = "Work"
        tag1.colorString = "orange"
        let tag2 = Tag(context: managedObjectContext)
        tag2.name = "Programming"
        tag2.colorString = "rose"
        project1.name = "Pre-thesis"
        project1.color = "rose"
        project1.tags = [tag1, tag2]
        mock1.startTime = Date()
        mock1.finishedTime = Date()
        mock1.duration = 1500
        mock1.project = project1
        
        let mock2 = pomodoroSessionPersistence.createNewSession(in: managedObjectContext)
        let project2 = Project(context: managedObjectContext)
        project2.name = "College"
        project2.color = "rose"
        mock2.startTime = Date()
        mock2.finishedTime = Date()
        mock2.duration = 1500
        mock2.project = project2
        
        pomodoroSessionPersistence.save(context: managedObjectContext)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    Text("Debug helper:")
                    Button {
                        UserDefaults.standard.set(false, forKey: UserDefaults.keyHasFinishedOnboarding)
                    } label: {
                        Text("Reset onboarding")
                    }
                    Text("Note: You need to change the app for the changes to take effect")
                }
                
                List {
                    ForEach(lastPomodoroSessions) { pomodoroSession in
                        VStack(alignment: .leading) {
                            Text(pomodoroSession.project?.name ?? "No project name")
                            
                            HStack {
                                ForEach(pomodoroSession.project?.arrayOfTags() ?? []) { tag in
                                    TagView(tag: tag, isRemovable: false)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Debug core data")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        withAnimation {
                            createMockCoreData()
                        }
                    } label: {
                        Text("Add mocks")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        withAnimation {
                            for session in lastPomodoroSessions {
                                managedObjectContext.delete(session)
                            }
                            
                            pomodoroSessionPersistence.save(context: managedObjectContext)
                        }
                    } label: {
                        Text("Delete all")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

//
//  FocusFlowApp.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

@main
struct FocusFlow_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     PersistenceController.shared.container.viewContext
                )
                .environmentObject(MainViewModel())
//                .onTapGesture {
//                    withAnimation {
//                        createMock()
//                    }
//                }
        }
    }
    
    func createMock() {
        let context = PersistenceController.shared.container.viewContext
        
        let mock1 = Pomodoro(context: context)
        let project1 = Project(context: context)
        let tag1 = Tag(context: context)
        tag1.name = "Work"
        tag1.colorString = "orange"
        let tag2 = Tag(context: context)
        tag2.name = "Programming"
        tag2.colorString = "rose"
        project1.name = "Pre-thesis"
        project1.color = "orange"
        project1.tags = [tag1, tag2]
        mock1.startTime = Date(timeIntervalSinceNow: -60 * 60)
        mock1.finishedTime = Date(timeIntervalSinceNow: -30 * 60)
        mock1.duration = 1500
        mock1.project = project1
//        mock1.isOngoing = true
        
        let mock2 = Pomodoro(context: context)
        let project2 = Project(context: context)
        project2.name = "College"
        project2.color = "rose"
        mock2.startTime = Date(timeIntervalSinceNow: -120 * 60)
        mock2.finishedTime = Date(timeIntervalSinceNow: -90 * 60)
        mock2.duration = 1500
        mock2.project = project2
        
        try? context.save()
    }
}

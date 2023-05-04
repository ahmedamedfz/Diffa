//
//  SessionScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

struct PomodoroScreenView: View {
    
    @EnvironmentObject var sessionManager: PomodoroSessionManager
    
//    @State var progress: Double = 0
    @State var passedSeconds: Int = 0
    
    /// The target duration
    @State var duration: Int = 0

    var body: some View {
        VStack {
            Text("Session")
                .onReceive(sessionManager.timer) { _ in
//                    passedSeconds += 1
    //                progress = Double(passedSeconds) / Double(duration)
    //                print("progress: \(progress)")
                    
                    passedSeconds += 1
                    sessionManager.updateProgress(with: passedSeconds)
                    
                    print("passed seconds: \(passedSeconds)")
                    print("progress: \(sessionManager.progress)")
                }
            
            Text("Progress: \(sessionManager.progress)")
        }
        .onAppear {
//            let session = sessionManager.session
//            self.duration = Int(session!.duration)
            
            print("session: \(sessionManager.session)")
            print("session start time: \(sessionManager.session.startTime)")
            
            self.passedSeconds = Int(Date.now.timeIntervalSince(sessionManager.session.startTime!))
        }
    }
}

struct SessionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let sessionManager = PomodoroSessionManager.shared
        
        // TODO: Fetch these properties from Pomodoro ManagedObject
        let startTime = Date(timeIntervalSinceNow: -5 * 60)
        let duration = 25 * 60
        
        return PomodoroScreenView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(sessionManager)
    }
}

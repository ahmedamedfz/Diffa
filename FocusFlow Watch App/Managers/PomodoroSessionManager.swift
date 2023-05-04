//
//  PomodoroSessionManager.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import CoreData

class PomodoroSessionManager: ObservableObject {
    
    private let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    private(set) var session: Pomodoro!
    private(set) var durationTarget = 0
    
    @Published var progress: Double = 0
    @Published var timer = Timer
                            .publish(every: 1, on: .main, in: .common)
//                            .sink { <#Date#> in
//                                <#code#>
//                            }
    
//    init(withProject project: Project, targetDuration: Int) { // TODO: change preview to shared
//        let context = PersistenceController.preview.container.viewContext
//        let projectObjectID = project.objectID
//        let managedObject = context.object(with: projectObjectID)
//        guard let project = managedObject as? Project else {
//            fatalError("Can't convert Pomodoro from NSManagedObjectID")
//        }
//
//        let session = Pomodoro(context: context)
//        session.project = project
//        session.duration = Int64(targetDuration)
//        self.session = session
//    }
    
    /// Warning: To use PomodoroSessionManager, you have to call startNewSession() first.
    static let shared = PomodoroSessionManager()
    
    private init() {}
    
//    init(in context: NSManagedObjectContext) {
//        self.context = context
//    }
    
    func startNewSession(for project: Project, withDurationTarget durationTarget: Int) {
        let newSession = createNewSession(from: project)
        newSession.isOngoing = true
        newSession.startTime = .now
        newSession.duration = Int64(durationTarget)
        self.durationTarget = durationTarget
        
        self.session = newSession
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func updateProgress(with secondsPassed: Int) {
        progress = Double(secondsPassed) / Double(durationTarget)
    }
    
    func stopSession() {
        session.isOngoing = false
        timer.connect().cancel()
    }
    
}

// MARK: - Helpers
extension PomodoroSessionManager {
    private func createNewSession(from project: Project) -> Pomodoro {
        let projectObjectID = project.objectID
        let managedObject = context.object(with: projectObjectID)
        guard let project = managedObject as? Project else {
            fatalError("Can't convert Pomodoro from NSManagedObjectID")
        }
        
        let newSession = Pomodoro(context: context)
        newSession.project = project
        
        return newSession
    }
}

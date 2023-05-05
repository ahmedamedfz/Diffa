//
//  PomodoroSessionManager.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import CoreData

class PomodoroSessionManager: ObservableObject {
    
    private let context: NSManagedObjectContext
    private(set) var session: Pomodoro!
    private(set) var durationTarget = 0
    
    @Published var progress: Double = 0
    @Published private(set) var passedSeconds = 0
    @Published var timer = Timer
                            .publish(every: 1, on: .main, in: .common)
    @Published var isPaused = false
    
    @Published var isShowingFinishSheet = false
    @Published var isShowingSheet = false
    @Published var isShowingResultSheet = false
    
    /// Warning: To use PomodoroSessionManager, you have to call startNewSession() or continueActiveSession() first.
    static let shared = PomodoroSessionManager()
    
    static let preview = PomodoroSessionManager(isPreview: true)
    
    private init(isPreview: Bool = false) {
        if isPreview {
            self.context = PersistenceController.preview.container.viewContext
        } else {
            self.context = PersistenceController.shared.container.viewContext
        }
    }
    
    func startNewSession(for project: Project, withDurationTarget durationTarget: Int) {
        let newSession = createNewSession(from: project)
        newSession.isOngoing = true
        newSession.startTime = .now
        newSession.duration = Int64(durationTarget)
        self.durationTarget = durationTarget
        self.session = newSession
        
        try? context.save()
        
        startTimer()
    }
    
    func continueActiveSession(_ session: Pomodoro) {
        self.session = session
        self.durationTarget = Int(session.duration)
        self.passedSeconds = Int(Date.now.timeIntervalSince(session.startTime ?? .now))
        
        startTimer()
    }
    
    func updateProgress() {
        passedSeconds += 1
        progress = Double(passedSeconds) / Double(durationTarget)
    }
    
    func finishSession() {
        session.isOngoing = false
        timer.connect().cancel()
        session.realizedDuration = Int64(passedSeconds)
        try? context.save()
    }
    
    func discardSession() {
        timer.connect().cancel()
//        self.session = nil
        context.delete(session)
        try? context.save()
    }
    
    func pauseSession() {
        timer.connect().cancel()
//        timer = Timer.publish(every: 1, on: .main, in: .common)
        isPaused = true
    }
    
    func resumeSession() {
        startTimer()
        isPaused = false
    }
    
}

// MARK: - Helpers
extension PomodoroSessionManager {
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
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

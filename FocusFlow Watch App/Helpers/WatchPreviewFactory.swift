//
//  WatchPreviewFactory.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import Foundation

struct WatchPreviewFactory {
    private let project = PersistenceController.projectsPreview.first!
    private let pomodoroSessionManager = PomodoroSessionManager.preview
    
    func makeSessionManager(withDurationTarget durationTarget: Int = 1 * 60) -> PomodoroSessionManager {
        pomodoroSessionManager.startNewSession(for: project, withDurationTarget: durationTarget)
        return pomodoroSessionManager
    }
}

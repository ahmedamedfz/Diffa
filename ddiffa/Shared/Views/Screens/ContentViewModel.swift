//
//  ContentViewModel.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var hasFinishedOnboarding = false
    
    let settingsManager: SettingsManager
    
    init() {
        self.settingsManager = SettingsManager.shared
        self.hasFinishedOnboarding = settingsManager.hasFinishedOnboarding()
    }
    
    func finishOnboarding() {
        hasFinishedOnboarding = true
        settingsManager.setHasFinishedOnboarding()
    }
}

//
//  SettingsManager.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import Foundation

class SettingsManager {
    
    static let shared = SettingsManager()
    
    private init() {}
    
    func hasFinishedOnboarding() -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaults.keyHasFinishedOnboarding)
    }
    
    func setHasFinishedOnboarding() {
        UserDefaults.standard.set(true, forKey: UserDefaults.keyHasFinishedOnboarding)
    }
}

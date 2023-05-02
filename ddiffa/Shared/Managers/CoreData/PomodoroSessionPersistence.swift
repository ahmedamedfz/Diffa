//
//  PomodoroSessionPersistence.swift
//  ddiffa
//
//  Created by Dimas on 02/05/23.
//

import CoreData

class PomodoroSessionPersistence {
    static let shared = PomodoroSessionPersistence()
    
    private init() {}
    
    func createNewSession(in context: NSManagedObjectContext) -> Pomodoro {
        let session = Pomodoro(context: context)
        
        return session
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to save context: \(context)")
        }
    }
    
}

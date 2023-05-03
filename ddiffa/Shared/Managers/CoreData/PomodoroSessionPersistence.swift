//
//  PomodoroSessionPersistence.swift
//  ddiffa
//
//  Created by Dimas on 02/05/23.
//

import CoreData

class PomodoroSessionPersistence {
    
    static let shared = PomodoroSessionPersistence()
    
    static var projectQueryFetchRequest: NSFetchRequest<Project> = {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.fetchLimit = 2
        request.sortDescriptors = []
        
        return request
    }()
    
    static var tagQueryFetchRequest: NSFetchRequest<Tag> = {
        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
        request.fetchLimit = 2
        request.sortDescriptors = []
        
        return request
    }()
    
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
    
    func resetChanged(in context: NSManagedObjectContext) {
        context.rollback()
    }
    
}

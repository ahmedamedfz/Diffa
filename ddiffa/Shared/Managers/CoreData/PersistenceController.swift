//
//  PersistanceController.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 01/05/23.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Model")
        
//        let description = container.persistentStoreDescriptions.first!
//
//        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "TODO_cloudContainerID")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - FetchRequests

extension PersistenceController {
    static let projectsRequest: NSFetchRequest<Project> = {
        let request = Project.fetchRequest()
        
        request.sortDescriptors = []
        
        return request
    }()
    
    static let onGoingSessionRequest: NSFetchRequest<Pomodoro> = {
        let request = Pomodoro.fetchRequest()
        
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "isOngoing == true")
        request.sortDescriptors = []
        
        return request
    }()
}

// MARK: - Preview

extension PersistenceController {
    static let preview: PersistenceController = {
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.container.viewContext
        let pomodoroSessionPersistence = PomodoroSessionPersistence.shared
        
        let mock1 = pomodoroSessionPersistence.createNewSession(in: context)
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
        mock1.startTime = Date()
        mock1.finishedTime = Date(timeIntervalSinceNow: 60 * 60)
        mock1.duration = 1500
        mock1.project = project1
        
        let mock2 = pomodoroSessionPersistence.createNewSession(in: context)
        let project2 = Project(context: context)
        project2.name = "College"
        project2.color = "rose"
        mock2.startTime = Date()
        mock2.finishedTime = Date(timeIntervalSinceNow: 120 * 60)
        mock2.duration = 1500
        mock2.project = project2
        
        return persistenceController
    }()
    
    static var pomodoroSessionsPreview: [Pomodoro] {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pomodoro> = Pomodoro.fetchRequest()
        fetchRequest.fetchLimit = 2
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Pomodoro.project?.name, ascending: false)]
        
        let results = try? context.fetch(fetchRequest)
        
        return results!
    }
    
    static var projectsPreview: [Project] {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        fetchRequest.fetchLimit = 2
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.name, ascending: false)]
        
        let results = try? context.fetch(fetchRequest)
        
        return results!
    }
}

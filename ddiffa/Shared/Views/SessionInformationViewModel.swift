//
//  SessionInformationViewModel.swift
//  ddiffa
//
//  Created by Dimas on 03/05/23.
//

import SwiftUI
import CoreData

extension SessionInformationView {
    class ViewModel: ObservableObject {
        
        @Published var isProjectFocused = false
        @Published var needToHandleKeyboardDissmiss = false
        
        @Published var projectQuery = ""
        @Published var tags: [Tag] = []
        @Published var tagQuery: String = ""
        
        var currentSession: Pomodoro?
        
        func updateView() {
            objectWillChange.send()
        }
        
        func startSession() {
            print("tags:")
        }
        
        func updateSession(in context: NSManagedObjectContext, projectObjectID: NSManagedObjectID) {
            let projectManagedObjectCopy = try! context.existingObject(with: projectObjectID)
            let projectCopy = projectManagedObjectCopy as? Project
            
            if currentSession == nil {
                currentSession = Pomodoro(context: context)
            }
            
            currentSession?.project = projectCopy
            
            tags = projectCopy?.arrayOfTags() ?? []

            tags.forEach { tag in
                print(tag.name)
            }
            
            objectWillChange.send()
        }
        
        func handleProjectChange(to projectName: String, in context: NSManagedObjectContext) {
            if currentSession == nil {
                currentSession = Pomodoro(context: context)
            }
            
            let newProject = Project(context: context)
            newProject.name = projectName
            newProject.color = "rose" // TODO: change dynamically
            
            if let currentSession {
                newProject.addToPomodoroSessions(currentSession)
                tags = []
            }
        }
        
        func remove(tag: NSManagedObject, from session: NSManagedObject) {
            guard let tag = tag as? Tag, let session = session as? Pomodoro else { return }
            
            if let project = session.project {
                tag.removeFromProject(project)
                project.removeFromTags(tag)

                withAnimation {
                    let indexToDelete = tags.firstIndex { $0.name == tag.name && $0.colorString == tag.colorString }
                    if let indexToDelete {
                        tags.remove(at: indexToDelete)
                    }
                }
            }
        }
        
        func addNewTag(name: String, colorString: String, toContext context: NSManagedObjectContext) {
            let newTag = Tag(context: context)
            
            newTag.name = name
            newTag.colorString = colorString
      
            addTag(newTag, to: context)
        }
        
        func addTag(_ tag: Tag, to context: NSManagedObjectContext) {
            if currentSession == nil {
                currentSession = Pomodoro(context: context)
            }
            
            if let project = currentSession?.project {
                tag.addToProject(project)
                
                print("added new tag. Now tags: \(tags)")
            } else {
                currentSession?.project = Project(context: context)
                tag.addToProject(currentSession!.project!)
            }
            
            tags.append(tag)
        }
        
    }
}

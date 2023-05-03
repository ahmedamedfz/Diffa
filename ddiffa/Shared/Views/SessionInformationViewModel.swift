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
        
        init(
            isExpanded: Binding<Bool>,
            tags: Binding<[Tag]>,
            tagQuery: Binding<String>
        ) {
//            self._tags = tags
//            self._tagQuery = tagQuery
//            self.currentSession = currentSession
        }
        
        func updateView() {
            objectWillChange.send()
        }
        
        func startSession() {
            print("tags:")
            tags.forEach { tag in
                print(tag.name)
            }
        }
        
        func updateSession(in context: NSManagedObjectContext, projectObjectID: NSManagedObjectID) {
            let projectManagedObjectCopy = try! context.existingObject(with: projectObjectID)
            let projectCopy = projectManagedObjectCopy as? Project
            
            currentSession = Pomodoro(context: context)
            currentSession?.project = projectCopy
            
            tags = projectCopy?.arrayOfTags() ?? []

            tags.forEach { tag in
                print(tag.name)
            }
            
            objectWillChange.send()
        }
        
        func remove(tag: NSManagedObject, from session: NSManagedObject) {
            guard let tag = tag as? Tag, let session = session as? Pomodoro else { return }
            
            if let project = session.project {
                tag.removeFromProject(project)
                project.removeFromTags(tag)
                
//                project.arrayOfTags().forEach { tag in
//                    print(tag.name)
//                }
                
                withAnimation {
                    let indexToDelete = tags.firstIndex { $0.name == tag.name && $0.colorString == tag.colorString }
                    if let indexToDelete {
                        tags.remove(at: indexToDelete)
                    }
                }
            }
        }
        
    }
}

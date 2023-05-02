//
//  Project+CoreDataProperties.swift
//  ddiffa
//
//  Created by Dimas on 02/05/23.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var pomodoroSessions: Set<Pomodoro>?
    @NSManaged public var tags: Set<Tag>?

}

// MARK: Generated accessors for pomodoroSessions
extension Project {

    @objc(addPomodoroSessionsObject:)
    @NSManaged public func addToPomodoroSessions(_ value: Pomodoro)

    @objc(removePomodoroSessionsObject:)
    @NSManaged public func removeFromPomodoroSessions(_ value: Pomodoro)

    @objc(addPomodoroSessions:)
    @NSManaged public func addToPomodoroSessions(_ values: Set<Pomodoro>)

    @objc(removePomodoroSessions:)
    @NSManaged public func removeFromPomodoroSessions(_ values: Set<Pomodoro>)

}

// MARK: Generated accessors for tags
extension Project {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: Set<Tag>)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: Set<Tag>)

}

extension Project : Identifiable {

}

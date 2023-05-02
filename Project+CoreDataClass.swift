//
//  Project+CoreDataClass.swift
//  ddiffa
//
//  Created by Dimas on 02/05/23.
//
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {

}

extension Project {
    func arrayOfTags() -> [Tag] {
        if let items = self.tags as? Set<Tag> {
            return Array(items)
        } else {
            return []
        }
    }
}

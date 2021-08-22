//
//  Objective+CoreDataClass.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//
//

import Foundation
import CoreData
import Entities

@objc(Objective)
public class Objective: NSManagedObject, EntityModel {

    // MARK: - EntityModel
    
    public var snapshot: Entities.Objective {
        
        guard
            let id = self.id,
            let created = self.created,
            let title = self.title
        else {
            preconditionFailure("Invalid managed object. Unable to create entity snapshot.")
        }
        
        return Entities.Objective(
            id: id,
            created: created,
            lastEdited: lastEdited,
            title: title,
            summary: summary
        )
    }
    
    /// Doesn't update relationships
    public func update(with value: Entities.Objective) {
        id = value.id
        created = value.created
        lastEdited = value.lastEdited
        title = value.title
        summary = value.summary
    }
}

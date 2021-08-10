//
//  Activity+CoreDataClass.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//
//

import Foundation
import CoreData
import Entities

@objc(Activity)
public class Activity: NSManagedObject, EntityModel {

    public var snapshot: Entities.Activity {
        
        guard
            let id = self.id,
            let created = self.created,
            let title = self.title
        else {
            preconditionFailure("Invalid managed object. Unable to create entity snapshot.")
        }
        
        return Entities.Activity(
            id: id,
            created: created,
            lastEdited: lastEdited,
            title: title
        )
    }
    
    public func update(with value: Entities.Activity) {
        id = value.id
        created = value.created
        lastEdited = value.lastEdited
        title = value.title
    }
}

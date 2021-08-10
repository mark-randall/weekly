//
//  ActivityGoal+CoreDataClass.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//
//

import Foundation
import CoreData
import Entities

@objc(ActivityGoal)
public class ActivityGoal: NSManagedObject, EntityModel  {

    public var snapshot: Entities.ActivityGoal {
        
        guard
            let id = self.id,
            let created = self.created,
            let activity = self.activity,
            let importance = Entities.ActivityGoalImportance(rawValue: Int(importance))
        else {
            preconditionFailure("Invalid managed object. Unable to create entity snapshot.")
        }
        
        return Entities.ActivityGoal(
            id: id,
            created: created,
            lastEdited: lastEdited,
            activity: activity.snapshot,
            importance: importance,
            type: (completionGoal == 1) ? .task : .multiple(Int(completionGoal)),
            timesCompleted: Int(self.timesCompleted)
        )
    }
    
    /// Doesn't update relationships
    public func update(with value: Entities.ActivityGoal) {
        id = value.id
        created = value.created
        lastEdited = value.lastEdited
        switch value.type {
        case .task:
            completionGoal = 1
        case .multiple(let times):
            completionGoal = Int16(times)
        }
        timesCompleted = Int16(value.timesCompleted)
        importance = Int16(value.importance.rawValue)
    }
}

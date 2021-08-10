//
//  WeekGoal+CoreDataClass.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//
//

import Foundation
import CoreData
import Entities

@objc(WeekGoal)
public class WeekGoal: NSManagedObject, EntityModel {
    
    public var snapshot: Entities.WeekGoal {
        
        guard
            let id = self.id,
            let created = self.created,
            let startDate = self.startDate,
            let activityGoals = self.activityGoals as? Set<ActivityGoal>
        else {
            preconditionFailure("Invalid managed object. Unable to create entity snapshot.")
        }
        
        return Entities.WeekGoal(
            id: id,
            created: created,
            lastEdited: lastEdited,
            startDate: startDate,
            activityGoals: activityGoals.map({ $0.snapshot })
        )
    }
    
    public func update(with value: Entities.WeekGoal) {
        id = value.id
        created = value.created
        lastEdited = value.lastEdited
        startDate = value.startDate
    }
}


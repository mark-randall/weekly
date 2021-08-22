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

@objc(Goal)
public class Goal: NSManagedObject, EntityModel {
    
    public var snapshot: Entities.Goal {
        
        guard
            let id = self.id,
            let created = self.created,
            let startDate = self.startDate,
            let activityGoals = self.activities as? Set<GoalActivity>,
            let objective = self.objective
        else {
            preconditionFailure("Invalid managed object. Unable to create entity snapshot.")
        }
        
        return Entities.Goal(
            id: id,
            created: created,
            lastEdited: lastEdited,
            startDate: startDate,
            objective: objective.snapshot,
            activities: activityGoals.map({ $0.snapshot })
        )
    }
    
    public func update(with value: Entities.Goal) {
        id = value.id
        created = value.created
        lastEdited = value.lastEdited
        startDate = value.startDate
    }
}


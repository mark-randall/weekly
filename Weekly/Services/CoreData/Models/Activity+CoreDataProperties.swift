//
//  Activity+CoreDataProperties.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: String?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var title: String?
    @NSManaged public var goals: NSSet?

}

// MARK: Generated accessors for goals
extension Activity {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: GoalActivity)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: GoalActivity)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}

extension Activity : Identifiable {

}

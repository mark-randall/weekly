//
//  Goal+CoreDataProperties.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: String?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var activities: NSSet?
    @NSManaged public var objective: Objective?

}

// MARK: Generated accessors for activities
extension Goal {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: GoalActivity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: GoalActivity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension Goal : Identifiable {

}

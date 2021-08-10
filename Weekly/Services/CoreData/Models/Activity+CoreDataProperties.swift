//
//  Activity+CoreDataProperties.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var created: Date?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var activityGoals: NSSet?

}

// MARK: Generated accessors for activityGoals
extension Activity {

    @objc(addActivityGoalsObject:)
    @NSManaged public func addToActivityGoals(_ value: ActivityGoal)

    @objc(removeActivityGoalsObject:)
    @NSManaged public func removeFromActivityGoals(_ value: ActivityGoal)

    @objc(addActivityGoals:)
    @NSManaged public func addToActivityGoals(_ values: NSSet)

    @objc(removeActivityGoals:)
    @NSManaged public func removeFromActivityGoals(_ values: NSSet)

}

extension Activity : Identifiable {

}

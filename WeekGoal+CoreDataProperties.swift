//
//  WeekGoal+CoreDataProperties.swift
//  WeeklyTests
//
//  Created by Mark Randall on 8/10/21.
//
//

import Foundation
import CoreData


extension WeekGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeekGoal> {
        return NSFetchRequest<WeekGoal>(entityName: "WeekGoal")
    }

    @NSManaged public var id: String?
    @NSManaged public var created: Date?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var activityGoals: NSSet?

}

// MARK: Generated accessors for activityGoals
extension WeekGoal {

    @objc(addActivityGoalsObject:)
    @NSManaged public func addToActivityGoals(_ value: ActivityGoal)

    @objc(removeActivityGoalsObject:)
    @NSManaged public func removeFromActivityGoals(_ value: ActivityGoal)

    @objc(addActivityGoals:)
    @NSManaged public func addToActivityGoals(_ values: NSSet)

    @objc(removeActivityGoals:)
    @NSManaged public func removeFromActivityGoals(_ values: NSSet)

}

extension WeekGoal : Identifiable {

}

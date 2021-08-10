//
//  ActivityGoal+CoreDataProperties.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//
//

import Foundation
import CoreData


extension ActivityGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityGoal> {
        return NSFetchRequest<ActivityGoal>(entityName: "ActivityGoal")
    }

    @NSManaged public var id: String?
    @NSManaged public var created: Date?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var importance: Int16
    @NSManaged public var timesCompleted: Int16
    @NSManaged public var completionGoal: Int16
    @NSManaged public var activity: Activity?
    @NSManaged public var week: WeekGoal?

}

extension ActivityGoal : Identifiable {

}

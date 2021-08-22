//
//  GoalActivity+CoreDataProperties.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//
//

import Foundation
import CoreData


extension GoalActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalActivity> {
        return NSFetchRequest<GoalActivity>(entityName: "GoalActivity")
    }

    @NSManaged public var completionGoal: Int16
    @NSManaged public var created: Date?
    @NSManaged public var id: String?
    @NSManaged public var importance: Int16
    @NSManaged public var lastEdited: Date?
    @NSManaged public var timesCompleted: Int16
    @NSManaged public var activity: Activity?
    @NSManaged public var goal: Goal?

}

extension GoalActivity : Identifiable {

}

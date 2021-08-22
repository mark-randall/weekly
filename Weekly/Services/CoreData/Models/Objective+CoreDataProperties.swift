//
//  Objective+CoreDataProperties.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//
//

import Foundation
import CoreData


extension Objective {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Objective> {
        return NSFetchRequest<Objective>(entityName: "Objective")
    }

    @NSManaged public var id: String?
    @NSManaged public var created: Date?
    @NSManaged public var lastEdited: Date?
    @NSManaged public var title: String?
    @NSManaged public var summary: String?
    @NSManaged public var goals: NSSet?

}

// MARK: Generated accessors for goals
extension Objective {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}

extension Objective : Identifiable {

}

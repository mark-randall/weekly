//
//  Goal+CoreDataProperties.swift
//  Weekly
//
//  Created by Mark Randall on 5/28/21.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var isReoccuring: Bool

}

extension Goal : Identifiable {

}

//
//  WeekGoal.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

import Foundation

public struct WeekGoal: Entity {
    
    // MARK: - EntityModel
    
    public let id: String
    public let created: Date
    public var lastEdited: Date?
    
    // MARK: - Init
    
    public let startDate: Date
    public var activityGoals: [ActivityGoal] = []
    
    public init(id: String, created: Date, lastEdited: Date?, startDate: Date, activityGoals: [ActivityGoal]) {
        self.id = id
        self.created = created
        self.lastEdited = lastEdited
        self.startDate = startDate
        self.activityGoals = activityGoals
    }
    
    // MARK: - Computed
    
    public var isCompleted: Bool {
        return percentCompleted == 1.0
    }
    
    public var percentCompleted: Double {
        return Double(activityGoals.filter({ $0.isCompleted }).count) / Double(activityGoals.count)
    }
}

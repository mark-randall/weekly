//
//  WeekGoal.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

import Foundation

public enum GoalDuration {
    case week
}

public struct Goal: Entity {
    
    // MARK: - EntityModel
    
    public let id: String
    public let created: Date
    public var lastEdited: Date?
    
    // MARK: - Init
    
    public let startDate: Date
    public var endDate: Date
    public var activities: [GoalActivity] = []
    public let objective: Objective
    
    public init(
        id: String,
        created: Date,
        lastEdited: Date?,
        startDate: Date,
        duration: GoalDuration = .week,
        objective: Objective,
        activities: [GoalActivity]
    ) {
        self.id = id
        self.created = created
        self.lastEdited = lastEdited
        self.startDate = startDate
        self.endDate = startDate.addingTimeInterval(60 * 60 * 24 * 7)
        self.objective = objective
        self.activities = activities
    }
    
    // MARK: - Computed
    
    public var isCompleted: Bool {
        return percentCompleted == 1.0
    }
    
    public var percentCompleted: Double {
        return Double(activities.filter({ $0.isCompleted }).count) / Double(activities.count)
    }
}

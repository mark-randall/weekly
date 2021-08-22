//
//  ActivityGoal.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

import Foundation

public enum GoalActivityType {
    case task
    case multiple(Int)
}

public enum GoalActivityImportance: Int {
    case low = 1
    case medium = 2
    case high = 3
}

public struct GoalActivity: Entity {
    
    // MARK: - EntityModel
    
    public let id: String
    public let created: Date
    public var lastEdited: Date?
    
    // MARK: - Init
    
    public let activity: Activity
    public var importance: GoalActivityImportance
    public var type: GoalActivityType
    public var timesCompleted: Int
    
    public init(
        id: String,
        created: Date,
        lastEdited: Date?,
        activity: Activity,
        importance: GoalActivityImportance = .medium,
        type: GoalActivityType = .task,
        timesCompleted: Int = 0
    ) {
        self.id = id
        self.created = created
        self.lastEdited = lastEdited
        self.activity = activity
        self.importance = importance
        self.type = type
        self.timesCompleted = timesCompleted
    }
    
    // MARK: - Computed
    
    public var isCompleted: Bool {
        
        switch type {
        case .task:
            return timesCompleted == 1
        case .multiple(let goal):
            return timesCompleted >= goal
        }
    }
    
    public var percentCompleted: Double {
        
        switch type {
        case .task:
            return Double(timesCompleted) / 1.0
        case .multiple(let goal):
            return Double(timesCompleted) / Double(goal)
        }
    }
        
    // MARK: - Mutate
    
    mutating public func activityWasCompleted() throws {
        
        switch type {
        case .task:
            assert(timesCompleted == 0, "activityWasCompleted can only be called once on ActivityGoal with type task.")
            guard timesCompleted == 0 else { throw NSError(domain: "com.mrandall.weekly.entities", code: 405, userInfo: [:]) }
        case .multiple:
            break
        }
        
        timesCompleted += 1
    }
    
    mutating public func activityUncompleted() throws {
        
        switch type {
        case .task:
            assert(timesCompleted == 1, "activityUncompleted can only be called once on ActivityGoal with type task which have previously been completed.")
            guard timesCompleted == 1 else { throw NSError(domain: "com.mrandall.weekly.entities", code: 405, userInfo: [:]) }
        case .multiple:
            break
        }
        
        timesCompleted -= 1
    }
}

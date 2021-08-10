//
//  WeeklyGoal.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

import Foundation

public struct WeekGoal: EntityModel {
    
    // MARK: - EntityModel
    
    public let id: String = UUID().uuidString
    public let created: Date = Date()
    public var lastEdited: Date?
    
    // MARK: - Init
    
    public var activities: [ActivityGoal] = []
    public let startDate: Date
    
    init(startDate: Date) {
        self.startDate = startDate
    }
    
    // MARK: - Computed
    
    var isCompleted: Bool {
        return percentCompleted == 1.0
    }
    
    var percentCompleted: Double {
        return Double(activities.filter({ $0.isCompleted }).count) / Double(activities.count)
    }
}

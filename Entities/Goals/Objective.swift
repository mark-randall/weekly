//
//  Objective.swift
//  Entities
//
//  Created by Mark Randall on 8/21/21.
//

import Foundation

public struct Objective: Entity {
    
    // MARK: - EntityModel
    
    public let id: String
    public let created: Date
    public var lastEdited: Date?
    
    // MARK: - Init
    
    public var title: String
    public var summary: String?
    public var goals: [Goal] = []
    
    public init(
        id: String,
        created: Date,
        lastEdited: Date?,
        title: String,
        summary: String? = nil
    ) {
        self.id = id
        self.created = created
        self.lastEdited = lastEdited
        self.title = title
        self.summary = summary
    }
    
    // MARK: - Computed
    
    var currentGoal: Goal? {
        goals.sorted(by: { $0.endDate > $1.endDate }).first
    }
}

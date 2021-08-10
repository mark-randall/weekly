//
//  Models.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

import Foundation

public struct Activity: Entity {
    
    // MARK: - EntityModel
    
    public let id: String
    public let created: Date
    public var lastEdited: Date?

    // MARK: - Init

    public let title: String
    
    public init(id: String, created: Date, lastEdited: Date?, title: String) {
        self.id = id
        self.created = created
        self.lastEdited = lastEdited
        self.title = title
    }
}

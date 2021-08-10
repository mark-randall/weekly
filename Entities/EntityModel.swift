//
//  EntityModel.swift
//  Entities
//
//  Created by Mark Randall on 8/9/21.
//

/// Base entity
public protocol Entity {
    var id: String { get }
    var created: Date { get }
    var lastEdited: Date? { get set }
}

/// Models which represent entities
public protocol EntityModel {
    associatedtype T: Entity
    
    var snapshot: T { get }
    func update(with: T)
}

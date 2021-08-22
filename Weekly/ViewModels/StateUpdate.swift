//
//  StateUpdate.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

@dynamicMemberLookup
struct StateUpdate<T: Equatable>: Equatable {
    var current: T
    var previous: T? = nil
    var isAnimated: Bool = true
    var force: Bool = false
    
    // Allows current.<property> to be acccessed with .<property> with a bit of Swift magic
    subscript<U>(dynamicMember keyPath: KeyPath<T, U>) -> U {
        return current[keyPath: keyPath]
    }
}

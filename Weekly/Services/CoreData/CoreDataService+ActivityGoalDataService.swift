//
//  CoreDataService+ActivityGoalDataService.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import Foundation
import Entities
import Combine
import CoreData

extension CoreDataService: ActivityGoalDataService {
    
    func createActivityGoal(activity: Entities.Activity, type: Entities.ActivityGoalType, importance: Entities.ActivityGoalImportance) -> AnyPublisher<Entities.ActivityGoal, Error> {
        
        do {
            let activityModel: Activity = try fetchFirst(predicate: NSPredicate(format: "id = %@", activity.id), context: saveContext)
            let model: ActivityGoal = try create()
            
            model.activity = activityModel
            model.update(with: Entities.ActivityGoal(
                id: UUID().uuidString,
                created: Date(),
                lastEdited: nil,
                activity: activity,
                importance: importance,
                type: type
            ))
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.ActivityGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateActivityGoal(withId id: String, type: Entities.ActivityGoalType, importance: Entities.ActivityGoalImportance) -> AnyPublisher<Entities.ActivityGoal, Error> {
        
        do {
            let model: ActivityGoal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            value.type = type
            value.importance = importance
            model.update(with: value)
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.ActivityGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateActivityGoalAsCompleted(withId id: String) -> AnyPublisher<Entities.ActivityGoal, Error> {
        
        do {
            let model: ActivityGoal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            try value.activityWasCompleted()
            model.update(with: value)
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.ActivityGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateActivityGoalAsUncompletedCompleted(withId id: String) -> AnyPublisher<Entities.ActivityGoal, Error> {
        
        do {
            let model: ActivityGoal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            try value.activityUncompleted()
            model.update(with: value)
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.ActivityGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

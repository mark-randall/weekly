//
//  CoreDataService+GoalDataService.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import Foundation
import Entities
import Combine
import CoreData

extension CoreDataService: GoalDataService {
    
    func createGoal(withStartDate startDate: Date, objective: Entities.Objective, activityGoals: [Entities.GoalActivity]) -> AnyPublisher<Entities.Goal, Error> {
                
        do {
            let activityGoalModels: [GoalActivity] = try fetch(predicate: NSPredicate(format: "self.id in %@", activityGoals.map({ $0.id })), context: saveContext)
            let model: Goal = try create()
            
            model.activities = NSSet(array: activityGoalModels)
            model.update(with: Entities.Goal(
                id: UUID().uuidString,
                created: Date(),
                lastEdited: nil,
                startDate: startDate,
                objective: objective,
                activities: activityGoals
            ))
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.Goal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchActiveGoal() -> AnyPublisher<Entities.Goal, Error> {

        do {
            let model: Goal = try fetchFirst(sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: false)])

            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.Goal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateGoal(withId id: String, activityGoals: [Entities.GoalActivity]) -> AnyPublisher<Entities.Goal, Error> {
        
        do {
            let model: Goal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id))
            let existingActivityGoals = model.activities
            let ids = activityGoals.map { $0.id }
            
            // Delete any activityGoals not in update
            let deletedExistingActivityGoals = existingActivityGoals?.filtered(using: NSPredicate(format: "NOT id IN %@", ids))
            deletedExistingActivityGoals?
                .compactMap { $0 as? NSManagedObject }
                .forEach { delete($0) }
            
            let newExistingActivityGoals: [GoalActivity] = try fetch(predicate: NSPredicate(format: "self.id in %@", ids), context: saveContext)
            model.activities = NSSet(array: newExistingActivityGoals)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.Goal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func deleteGoal(withId id: String) -> AnyPublisher<Bool, Error> {
        do {
            let model: Goal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
                        
            delete(model)
            
            try save()
            
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Bool, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func createGoalActivity(activity: Entities.Activity, type: Entities.GoalActivityType, importance: Entities.GoalActivityImportance) -> AnyPublisher<Entities.GoalActivity, Error> {
        
        do {
            let activityModel: Activity = try fetchFirst(predicate: NSPredicate(format: "id = %@", activity.id), context: saveContext)
            let model: GoalActivity = try create()
            
            model.activity = activityModel
            model.update(with: Entities.GoalActivity(
                id: UUID().uuidString,
                created: Date(),
                lastEdited: nil,
                activity: activity,
                importance: importance,
                type: type
            ))
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.GoalActivity, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateGoalActivity(withId id: String, type: Entities.GoalActivityType, importance: Entities.GoalActivityImportance) -> AnyPublisher<Entities.GoalActivity, Error> {
        
        do {
            let model: GoalActivity = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            value.type = type
            value.importance = importance
            model.update(with: value)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.GoalActivity, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateGoalActivityAsCompleted(withId id: String) -> AnyPublisher<Entities.GoalActivity, Error> {
        
        do {
            let model: GoalActivity = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            try value.activityWasCompleted()
            model.update(with: value)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.GoalActivity, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateGoalActivityAsUncompletedCompleted(withId id: String) -> AnyPublisher<Entities.GoalActivity, Error> {
        
        do {
            let model: GoalActivity = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            var value = model.snapshot
            try value.activityUncompleted()
            model.update(with: value)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.GoalActivity, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

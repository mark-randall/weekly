//
//  CoreDataService+WeeklyGoalDataService.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import Foundation
import Entities
import Combine
import CoreData

extension CoreDataService: WeeklyGoalDataService {
    
    func createWeekGoal(withStartDate startDate: Date, activityGoals: [Entities.ActivityGoal]) -> AnyPublisher<Entities.WeekGoal, Error> {
                
        do {
            let activityGoalModels: [ActivityGoal] = try fetch(predicate: NSPredicate(format: "self.id in %@", activityGoals.map({ $0.id })), context: saveContext)
            let model: WeekGoal = try create()
            
            model.activityGoals = NSSet(array: activityGoalModels)
            model.update(with: Entities.WeekGoal(
                id: UUID().uuidString,
                created: Date(),
                lastEdited: nil,
                startDate: startDate,
                activityGoals: activityGoals
            ))
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.WeekGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchWeekGoalForCurrentWeek() -> AnyPublisher<Entities.WeekGoal, Error> {

        do {
            let model: WeekGoal = try fetchFirst(sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: false)])

            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.WeekGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateWeekGoal(withId id: String, activityGoals: [Entities.ActivityGoal]) -> AnyPublisher<Entities.WeekGoal, Error> {
        
        do {
            let model: WeekGoal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id))
            let existingActivityGoals = model.activityGoals
            let ids = activityGoals.map { $0.id }
            
            // Delete any activityGoals not in update
            let deletedExistingActivityGoals = existingActivityGoals?.filtered(using: NSPredicate(format: "NOT id IN %@", ids))
            deletedExistingActivityGoals?
                .compactMap { $0 as? NSManagedObject }
                .forEach { delete($0) }
            
            let newExistingActivityGoals: [ActivityGoal] = try fetch(predicate: NSPredicate(format: "self.id in %@", ids), context: saveContext)
            model.activityGoals = NSSet(array: newExistingActivityGoals)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.WeekGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func deleteWeekGoal(withId id: String) -> AnyPublisher<Bool, Error> {
        do {
            let model: WeekGoal = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
                        
            delete(model)
            
            try save()
            
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Bool, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

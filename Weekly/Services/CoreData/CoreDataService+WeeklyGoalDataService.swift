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
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.WeekGoal, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchWeekGoal(withStartDate startDate: Date) -> AnyPublisher<Entities.WeekGoal, Error> {
        preconditionFailure()
    }
    
    func updateWeekGoal(withStartDate startDate: Date, addActivityGoals: [Entities.ActivityGoal]) -> AnyPublisher<Entities.WeekGoal, Error> {
        preconditionFailure()
    }
    
    func updateWeekGoal(withStartDate startDate: Date, updateActivityGoals: [Entities.ActivityGoal]) -> AnyPublisher<Entities.WeekGoal, Error> {
        preconditionFailure()
    }
    
    func updateWeekGoal(withStartDate startDate: Date, deleteActivityGoals: [Entities.ActivityGoal]) -> AnyPublisher<Entities.WeekGoal, Error> {
        preconditionFailure()
    }
    
    func deleteWeekGoal(withStartDate startDate: Date) -> AnyPublisher<Bool, Error> {
        preconditionFailure()
    }
}

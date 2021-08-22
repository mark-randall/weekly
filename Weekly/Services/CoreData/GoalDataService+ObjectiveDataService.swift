//
//  GoalDataService+ObjectiveDataService.swift
//  Weekly
//
//  Created by Mark Randall on 8/21/21.
//

import Foundation
import Entities
import Combine
import CoreData

extension CoreDataService: ObjectiveDataService {
    
    func createObjective(title: String, summary: String?) -> AnyPublisher<Entities.Objective, Error> {
        
        do {
            let model: Objective = try create()
            let value = Entities.Objective(id: UUID().uuidString, created: Date(), lastEdited: nil, title: title, summary: summary)
            
            model.update(with: value)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.Objective, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchObjectives() -> AnyPublisher<[Entities.Objective], Error> {
        
        do {
            let models: [Objective] = try fetch()
            
            return Just(models.map { $0.snapshot })
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<[Entities.Objective], Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateObjective(title: String, summary: String) -> AnyPublisher<Entities.Objective, Error> {
        preconditionFailure()
    }
    
    func deleteObjective(withId id: String) -> AnyPublisher<Bool, Error> {
        
        do {
            let model: Objective = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            delete(model)
            
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        } catch {
            return Fail<Bool, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

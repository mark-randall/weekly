//
//  CoreDataService+ActivityDataService.swift
//  Weekly
//
//  Created by Mark Randall on 8/10/21.
//

import Foundation
import Entities
import Combine
import CoreData

extension CoreDataService: ActivityDataService {
    
    func createActivity(title: String) -> AnyPublisher<Entities.Activity, Error> {
        
        do {
            let model: Activity = try create()
            let value = Entities.Activity(id: UUID().uuidString, created: Date(), lastEdited: nil, title: title)
            
            model.update(with: value)
            
            try save()
            
            return Just(model.snapshot)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<Entities.Activity, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchActivities() -> AnyPublisher<[Entities.Activity], Error> {

        do {
            let models: [Activity] = try fetch()
            
            return Just(models.map { $0.snapshot })
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail<[Entities.Activity], Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateObjective(title: String) -> AnyPublisher<Entities.Activity, Error> {
        preconditionFailure()
    }
    
    func deleteActivity(withId id: String) -> AnyPublisher<Bool, Error> {
        
        do {
            let model: Activity = try fetchFirst(predicate: NSPredicate(format: "id = %@", id), context: saveContext)
            
            delete(model)
            
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        } catch {
            return Fail<Bool, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

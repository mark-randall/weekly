//
//  CoreDataService.swift
//  Weekly
//
//  Created by Mark Randall on 5/27/21.
//

import Foundation
import CoreData
import UIKit

final class CoreDataService {

    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weekly")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        
        return container
    }()
        
    private(set) lazy var saveContext: NSManagedObjectContext = self.persistentContainer.newBackgroundContext()
    
    init(
        persistentContainer: NSPersistentContainer? = nil,
        notificationCenter: NotificationCenter = NotificationCenter.default
    ) {
  
        if let persistentContainer = persistentContainer {
            self.persistentContainer = persistentContainer
        }
        
        notificationCenter.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { [weak self] _ in
            
            do {
                try self?.save()
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }

    // MARK: - Core Data CRUD

    func save(context: NSManagedObjectContext? = nil) throws {
        let context = context ?? saveContext
        guard context.hasChanges else { return }
        try context.save()
    }
    
    // MARK: - Core Data CRUD support
    
    func create<T: NSManagedObject>(context: NSManagedObjectContext? = nil) throws -> T {
        let context = context ?? saveContext
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: "\(T.self)", into: context) as? T else {
            throw NSError(domain: "com.mrandall.weekly.coredataservice", code: 500, userInfo: [:])
        }
        return managedObject
    }
    
    func fetch<T: NSManagedObject>(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [],
        relationshipKeyPathsForPrefetching: [String]? = nil,
        limit: Int = Int.max,
        context: NSManagedObjectContext? = nil
    ) throws -> [T] {
        let context = context ?? persistentContainer.viewContext
        
        let entityName = "\(T.self)"
        let fetchedRequest = NSFetchRequest<T>(entityName: entityName)
        fetchedRequest.predicate = predicate
        fetchedRequest.sortDescriptors = sortDescriptors
        fetchedRequest.relationshipKeyPathsForPrefetching = relationshipKeyPathsForPrefetching
        fetchedRequest.fetchLimit = limit
        
        return try context.fetch(fetchedRequest)
    }
    
    func fetchFirst<T: NSManagedObject>(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [],
        relationshipKeyPathsForPrefetching: [String]? = nil,
        context: NSManagedObjectContext? = nil
    ) throws -> T {
        
        let fetch: [T] = try fetch(
            predicate: predicate,
            sortDescriptors: sortDescriptors,
            relationshipKeyPathsForPrefetching: relationshipKeyPathsForPrefetching,
            limit: 1,
            context: context
        )
        
        guard let first = fetch.first else {
            throw NSError(domain: "com.mrandall.weekly.coredataservice", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "Unable to fetch \(T.self) with predicate \(String(describing: predicate))"
            ])
        }
        
        return first
    }
            
    func delete(_ object: NSManagedObject, context: NSManagedObjectContext? = nil) {
        (context ?? saveContext).delete(object)
    }
}

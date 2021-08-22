//
//  CoreDataServiceTests.swift
//  WeeklyTests
//
//  Created by Mark Randall on 8/10/21.
//

import XCTest
@testable import Weekly
import CoreData
import Combine

class CoreDataServiceTests: XCTestCase {

    var mockPersistantContainer: NSPersistentContainer!

    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    override func setUpWithError() throws {

        let container = NSPersistentContainer(name: "Weekly", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
                                        
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        mockPersistantContainer = container
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateActivity_FetchActivities() throws {
        
        let service = CoreDataService(persistentContainer: mockPersistantContainer)

        let activity = try AwaitPublisherFirst(publisher: service.createActivity(title: "test"))
        let fetchedActivities = try AwaitPublisherFirst(publisher: service.fetchActivities())
        
        XCTAssertEqual(activity.title, "test")
        XCTAssertEqual(fetchedActivities.count, 1)
        XCTAssertEqual(fetchedActivities[0].title, "test")
    }
    
    func testUpdateActivityGoalAsCompleted_typeIsTask_isCompletedTrue() throws {
        
        let service = CoreDataService(persistentContainer: mockPersistantContainer)

        let activity = try AwaitPublisherFirst(publisher: service.createActivity(title: "test"))
        let activityGoal = try AwaitPublisherFirst(publisher: service.createGoalActivity(activity: activity, type: .task, importance: .medium))
        let updatedActivityGoal = try AwaitPublisherFirst(publisher: service.updateGoalActivityAsCompleted(withId: activityGoal.id))
        
        XCTAssertTrue(updatedActivityGoal.isCompleted)
        XCTAssertEqual(updatedActivityGoal.timesCompleted, 1)
        XCTAssertEqual(updatedActivityGoal.percentCompleted, 1.0)
    }
}

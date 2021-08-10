//
//  AcitivityGoalTests.swift
//  EntitiesTests
//
//  Created by Mark Randall on 8/10/21.
//

import XCTest
@testable import Entities

class AcitivityGoalTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testActivityWasCompleted_typeIsTask_isCompletedTrue() throws {
        let activity = Activity(id: UUID().uuidString, created: Date(), lastEdited: nil, title: "test")
        var activityGoal = ActivityGoal(id: UUID().uuidString, created: Date(), lastEdited: nil, activity: activity, importance: .medium, type: .task)
        
        try activityGoal.activityWasCompleted()
        
        XCTAssertTrue(activityGoal.isCompleted)
        XCTAssertEqual(activityGoal.timesCompleted, 1)
    }
}

//
//  Services.swift
//  Weekly
//
//  Created by Mark Randall on 5/27/21.
//

import Foundation
import Combine

public protocol ActivityDataService: AnyObject {
    
    func createActivity(title: String) -> AnyPublisher<Activity, Error>

    func fetchActivities() -> AnyPublisher<[Activity], Error>
    
    func deleteActivity(withId id: String) -> AnyPublisher<Bool, Error>
}

public protocol ActivityGoalDataService: AnyObject {
    
    func createActivityGoal(activity: Activity, type: ActivityGoalType, importance: ActivityGoalImportance) -> AnyPublisher<ActivityGoal, Error>
    
    func updateActivityGoal(withId id: String, type: ActivityGoalType, importance: ActivityGoalImportance) -> AnyPublisher<ActivityGoal, Error>
    
    func updateActivityGoalAsCompleted(withId id: String) -> AnyPublisher<ActivityGoal, Error>
    
    func updateActivityGoalAsUncompletedCompleted(withId id: String) -> AnyPublisher<ActivityGoal, Error>
    
    // Deleting is done with WeeklyGoalDataService's updateWeeklyGoal(withStartDate: Date, deleteActivities: [ActivityGoal])
}

public protocol WeeklyGoalDataService: AnyObject {
    
    func createWeekGoal(withStartDate startDate: Date, activityGoals: [ActivityGoal]) -> AnyPublisher<WeekGoal, Error>

    func fetchWeekGoal(withStartDate startDate: Date) -> AnyPublisher<WeekGoal, Error>

    func updateWeekGoal(withStartDate startDate: Date, addActivityGoals: [ActivityGoal]) -> AnyPublisher<WeekGoal, Error>
    
    func updateWeekGoal(withStartDate startDate: Date, updateActivityGoals: [ActivityGoal]) -> AnyPublisher<WeekGoal, Error>
    
    func updateWeekGoal(withStartDate startDate: Date, deleteActivityGoals: [ActivityGoal]) -> AnyPublisher<WeekGoal, Error>
    
    func deleteWeekGoal(withStartDate startDate: Date) -> AnyPublisher<Bool, Error>
}
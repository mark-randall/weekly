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
    
    func updateObjective(title: String) -> AnyPublisher<Activity, Error>
    
    func deleteActivity(withId id: String) -> AnyPublisher<Bool, Error>
}

public protocol ObjectiveDataService: AnyObject {
    
    func createObjective(title: String, summary: String?) -> AnyPublisher<Objective, Error>

    func fetchObjectives() -> AnyPublisher<[Objective], Error>
    
    func updateObjective(title: String, summary: String) -> AnyPublisher<Objective, Error>

    func deleteObjective(withId id: String) -> AnyPublisher<Bool, Error>
}

public protocol GoalDataService: AnyObject {
    
    func createGoal(withStartDate date: Date, objective: Objective, activityGoals: [GoalActivity]) -> AnyPublisher<Goal, Error>

    func fetchActiveGoal() -> AnyPublisher<Goal, Error>

    func updateGoal(withId id: String, activityGoals: [GoalActivity]) -> AnyPublisher<Goal, Error>
    
    func deleteGoal(withId id: String) -> AnyPublisher<Bool, Error>
    
    func createGoalActivity(activity: Activity, type: GoalActivityType, importance: GoalActivityImportance) -> AnyPublisher<GoalActivity, Error>
    
    func updateGoalActivity(withId id: String, type: GoalActivityType, importance: GoalActivityImportance) -> AnyPublisher<GoalActivity, Error>
    
    func updateGoalActivityAsCompleted(withId id: String) -> AnyPublisher<GoalActivity, Error>
    
    func updateGoalActivityAsUncompletedCompleted(withId id: String) -> AnyPublisher<GoalActivity, Error>
    
    // Deleting is done with WeeklyGoalDataService's updateWeeklyGoal(withStartDate: Date, deleteActivities: [ActivityGoal])
}

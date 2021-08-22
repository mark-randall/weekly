//
//  ViewController.swift
//  Weekly
//
//  Created by Mark Randall on 5/27/21.
//

import UIKit
import Entities
import Combine

class ViewController: UIViewController {

    private var cancelables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataService = CoreDataService()

        coreDataService.createActivity(title: "Test").flatMap({ activity in
            coreDataService.createGoalActivity(activity: activity, type: .task, importance: .high)
        }).flatMap({ activityGoal in
            coreDataService.createObjective(title: "Test", summary: nil).flatMap({ objective in
                coreDataService.createGoal(withStartDate: Date(), objective: objective, activityGoals: [activityGoal])
            })
        }).flatMap({ activityGoal in
            coreDataService.updateGoalActivityAsCompleted(withId: activityGoal.activities.first!.id)
        }).flatMap({ activityGoal in
            coreDataService.fetchActiveGoal()
        }).sink(receiveCompletion: { error in
            print(error)
        }, receiveValue: { success in
            print(success)
        }).store(in: &cancelables)
    }
}

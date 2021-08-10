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
            coreDataService.createActivityGoal(activity: activity, type: .task, importance: .high)
        }).flatMap({ activityGoal in
            coreDataService.createWeekGoal(withStartDate: Date(), activityGoals: [activityGoal])
        }).flatMap({ activityGoal in
            coreDataService.updateActivityGoalAsCompleted(withId: activityGoal.activityGoals.first!.id)
        }).flatMap({ activityGoal in
            coreDataService.fetchWeekGoalForCurrentWeek()
        }).sink(receiveCompletion: { error in
            print(error)
        }, receiveValue: { success in
            print(success)
        }).store(in: &cancelables)
        
        // let goal = Goal(
        // Do any additional setup after loading the view.
    }
}

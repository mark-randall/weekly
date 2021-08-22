//
//  UIViewController+PresentScreen.swift
//  NewsFeed
//
//  Created by Mark Randall on 6/24/21.
//

import UIKit
import SafariServices

enum ScreenPresentation {
    case modal(Screen)
    case modalWithoutNavigation(Screen)
    case show(Screen)
}

extension UIViewController {
    
    static func create(screen: Screen) -> UIViewController {
        
        switch screen {
        case .currentWeek(let viewModel):
           return CurrentWeekViewController(viewModel: viewModel)
        }
    }
}

extension UIViewController {
    
    func presentScreen(_ presentation: ScreenPresentation) {
        
        switch presentation {
        case .modalWithoutNavigation(let screen):
            let vc = UIViewController.create(screen: screen)
            present(vc, animated: true)
        case .modal(let screen):
            let vc = UIViewController.create(screen: screen)
            let nc = UINavigationController(rootViewController: vc)
            present(nc, animated: true)
        case .show(let screen):
            let vc = UIViewController.create(screen: screen)
            show(vc, sender: self)
        }
    }
}

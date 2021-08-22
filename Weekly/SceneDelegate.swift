//
//  SceneDelegate.swift
//  Weekly
//
//  Created by Mark Randall on 5/27/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        guard NSClassFromString("XCTest") == nil else { return }
        
        // Create root screen
        let viewModel = CurrentWeekViewModel()
        let vc = UIViewController.create(screen: .currentWeek(viewModel: viewModel))
        let nc = UINavigationController(rootViewController: vc)
        
        // Create window and make key
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        
        // TODO: replace
        // Save changes in the application's managed object context when the application transitions to the background.
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

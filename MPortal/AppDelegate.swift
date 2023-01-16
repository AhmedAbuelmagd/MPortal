//
//  AppDelegate.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        assignMainCoordinator()
        
        return true
    }
    
}

extension AppDelegate{
    func assignMainCoordinator(){
        coordinator = MainCoordinator(navigationController: UINavigationController(), parent: nil)
        coordinator?.start()
    }
}

//
//  MainCoordinator.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parent: Coordinator?
    
    
    init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = parent
    }
    var window: UIWindow?
    
    
    func start() {
        
        navigationController.delegate = self
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let home = HomeCoordinator(navigationController: navigationController, parent: self)
        childCoordinators = [home]
        home.start()
        window?.rootViewController = home.navigationController
        window?.makeKeyAndVisible()
    }
}


extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}

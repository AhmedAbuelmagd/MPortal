//
//  Coordinator.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit


// MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    
    // MARK: - Properties
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parent: Coordinator? { get set }
    
    // MARK: - Methods
    func start()
    func pop()
    func popToRoot()
    func newPresentNavigation(modalStyle: UIModalPresentationStyle) -> UINavigationController
    func dismiss(animated: Bool)
}


extension Coordinator {
    
    func pop(){
        navigationController.popViewController(animated: true)
    }
    
    func popTo<T>(classVC : T.Type){
        let controllersList = self.navigationController.viewControllers
        var selectedIndex = 0
        for (index,value) in controllersList.enumerated(){
            if value is T{
                selectedIndex = index
                break
            }
        }
        if selectedIndex >= 0{
            self.navigationController.popToViewController(controllersList[selectedIndex], animated: false)
        }
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func newPresentNavigation(modalStyle: UIModalPresentationStyle = .fullScreen) -> UINavigationController {
        let nav = UINavigationController()
        nav.modalPresentationStyle = modalStyle
        return nav
    }
    
    func dismiss(animated: Bool = true){
        //for most cases leave it on default true, you may need to change it to false if you're using custom closing animation for the viewcontroller
        navigationController.dismiss(animated: animated, completion: nil)
        parent?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator?){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}


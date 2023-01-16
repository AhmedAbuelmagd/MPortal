//
//  HomeCoordinatior.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parent: Coordinator?
    
    init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        let apiClient = HomeRemoteManager(requestManager: RequestManager.shared)
        let homeVM = HomeVM(apiClient: apiClient)
        let vc = HomeVC(homeVM: homeVM)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        navigationController.navigationBar.isHidden = true
        
    }
    
    func productDatails() {
        let vc = ProductDatailsVC()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        navigationController.navigationBar.isHidden = true
        
    }
    
    func filter(categories: CategoriesData? = nil, title: String, delegate: FilterDeleget, type: filterType, childrens: [Children]? = nil, proId: Int? = 0) {
        let apiClient = HomeRemoteManager(requestManager: RequestManager.shared)
        let homeVM = HomeVM(apiClient: apiClient)
        let vc = FilterVC(homeVM: homeVM)
        vc.coordinator = self
        vc.filterChildren = childrens
        vc.filterList = categories
        vc.filteTitle = title
        vc.delegte = delegate
        vc.type = type
        vc.proId = proId
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true, completion: nil)
//        navigationController.pushViewController(vc, animated: true)
        
    }
    
}


//
//  HomeCoordinatior.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH
import Moya

class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parent: Coordinator?
    
    init(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationController = navigationController
        self.parent = parent
    }
    
    func start() {
        let vc = LanguageVC()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        navigationController.navigationBar.isHidden = true
        
    }
    
    func home() {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        lazy var networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        lazy var provider = MoyaProvider<HomeAPIs>(plugins: [networkLogger])
        
        let apiClient = HomeRemoteManager(requestManager: RequestManager.shared, provider: provider)
        let homeVM = HomeVM(apiClient: apiClient)
        let vc = HomeVC(homeVM: homeVM)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        navigationController.navigationBar.isHidden = true
    }
    
    func productDatails(ads_banners: [Ads_banners]) {
        let vc = ProductDatailsVC()
        vc.coordinator = self
        vc.ads_banners = ads_banners
        navigationController.pushViewController(vc, animated: true)
        navigationController.navigationBar.isHidden = true
        
    }
    
    func filter(categories: CategoriesData? = nil, title: String, delegate: FilterDeleget, type: FilterType, childrens: [Children]? = nil, proId: Int? = 0, optionsData: [Children]? = nil, CategoryIndex: Int? = 0, categoryId: Int? = 0) {
        let vc = FilterVC()
        vc.coordinator = self
        vc.filterChildren = childrens
        vc.filterList = categories
        vc.optionsData = optionsData
        vc.filteTitle = title
        vc.delegte = delegate
        vc.type = type
        vc.proId = proId
        vc.CategoryIndex = CategoryIndex
        vc.categoryId = categoryId
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true, completion: nil)
        
    }
    func changeLanguage(){
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
        guard let topWindow = appDelegate.coordinator?.window else {return}
        UIView.transition(with: topWindow, duration: 0.55001, options: .transitionFlipFromLeft) {
        }
        appDelegate.coordinator?.start()
    }
}


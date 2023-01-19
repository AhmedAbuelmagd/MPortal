//
//  HomeNetworkManager.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
import Moya

protocol HomeNetworkProtocol {
    func getOptionsChild(id: Int, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>)->())
    func getAllCategories(completionHandler: @escaping (Result<BaseResponse<CategoriesData>, Error>)->())
    func getProperties(cat: String, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>)->())
}

class HomeRemoteManager: HomeNetworkProtocol {
    
    let requestManager: RequestManagerProtocol
    let provider: MoyaProvider<HomeAPIs>

    init(requestManager: RequestManagerProtocol,
         provider: MoyaProvider<HomeAPIs>) {
        self.requestManager = requestManager
        self.provider = provider
    }
    
    func getOptionsChild(id: Int, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>) -> ()) {
        requestManager.beginRequest(provider: provider, withTarget: HomeAPIs.getOptionsChild(id: id), model: BaseResponse<[PropertiesModel]>.self) { Result in
            completionHandler(Result)
        }
    }
    
    func getAllCategories(completionHandler: @escaping (Result<BaseResponse<CategoriesData>, Error>) -> ()) {
        requestManager.beginRequest(provider: provider, withTarget: HomeAPIs.getAllCategories, model: BaseResponse<CategoriesData>.self) { Result in
            completionHandler(Result)
        }
    }
    
    func getProperties(cat: String, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>) -> ()) {
        requestManager.beginRequest(provider: provider, withTarget: HomeAPIs.getProperties(cat: cat), model: BaseResponse<[PropertiesModel]>.self) { Result in
            completionHandler(Result)
        }
    }
}


//
//  HomeNetworkManager.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
//import Alamofire
//
protocol HomeNetworkProtocol {
    func getOptionsChild(id: Int, completionHandler: @escaping (Result<BaseResponse<[OptionModel]>, Error>)->())
    func getAllCategories(completionHandler: @escaping (Result<BaseResponse<CategoriesData>, Error>)->())
    func getProperties(cat: String, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>)->())

}


class HomeRemoteManager: HomeNetworkProtocol {
    
    private let requestManager: RequestManagerProtocol
    init(requestManager: RequestManagerProtocol) { self.requestManager = requestManager }
    
    func getOptionsChild(id: Int, completionHandler: @escaping (Result<BaseResponse<[OptionModel]>, Error>) -> ()) {
        requestManager.beginRequest(withTarget: HomeAPIs.getOptionsChild(id: id), model: BaseResponse<[OptionModel]>.self) { Result in
            completionHandler(Result)
        }
    }
    
    func getAllCategories(completionHandler: @escaping (Result<BaseResponse<CategoriesData>, Error>) -> ()) {
        requestManager.beginRequest(withTarget: HomeAPIs.getAllCategories, model: BaseResponse<CategoriesData>.self) { Result in
            completionHandler(Result)
        }
    }
    
    func getProperties(cat: String, completionHandler: @escaping (Result<BaseResponse<[PropertiesModel]>, Error>) -> ()) {
        requestManager.beginRequest(withTarget: HomeAPIs.getProperties(cat: cat), model: BaseResponse<[PropertiesModel]>.self) { Result in
            completionHandler(Result)
        }
    }
}


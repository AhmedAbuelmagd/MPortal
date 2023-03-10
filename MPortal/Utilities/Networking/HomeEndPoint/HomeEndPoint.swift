//
//  HomeEndPoint.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
import Moya
import MOLH

enum HomeEndPoint: String, CaseIterable {
    case GET_ALL_CATEGORIES = "get_all_cats"
    case PROPERTIES = "properties"
    case GET_OPTIONS_CHILD = "get-options-child"
}

enum HomeAPIs {
    case getAllCategories
    case getProperties(cat: String)
    case getOptionsChild(id: Int)
}

extension HomeAPIs: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.MAIN_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getAllCategories: return HomeEndPoint.GET_ALL_CATEGORIES.rawValue
        case .getProperties: return HomeEndPoint.PROPERTIES.rawValue
        case .getOptionsChild(let id): return "\(HomeEndPoint.GET_OPTIONS_CHILD.rawValue)/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getProperties(let cat):
            var parameters = [String: Any]()
            parameters["cat"] = cat
            return parameters
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        switch self{
            
        case .getAllCategories: return loadLocalJsonFile(fileName: FileName.MOCK_CATEGORY_DATA.rawValue)
        case .getProperties: return loadLocalJsonFile(fileName: FileName.MOCK_PROPERTIES_DATA.rawValue)
        case .getOptionsChild: return loadLocalJsonFile(fileName: FileName.MOCK_OPTIONS_DATA.rawValue)
            
        }
        
    }
    
    var task: Task {
        
        switch self {
        case .getAllCategories: return .requestPlain
        case .getProperties: return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
        case .getOptionsChild: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Accept-Language": MOLHLanguage.currentAppleLanguage(),"Content-Type": "application/json"]
    }
}
extension HomeAPIs {
    func loadLocalJsonFile(fileName: String) -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: Extensions.JSON.rawValue) else {
            fatalError()
        }
        return try! Data(contentsOf: url)
    }
}

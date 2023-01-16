//
//  RequestManager.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
import Moya

typealias SuccessHandler<S:Codable> = (S) -> ()
typealias ErrorHandler<E:Codable> = (E) -> ()


protocol RequestManagerProtocol {
    func beginRequest<T: Codable, ProvidertType: TargetType>(withTarget target: ProvidertType, model: T.Type, andHandler handler: @escaping (Result<T, Error>)-> Void)
    func beginRequest<ProviderType: TargetType>(withTarget target: ProviderType, andHandler handler: @escaping (Result<Data, Error>)-> Void)
}


class RequestManager: RequestManagerProtocol {
    
    static let shared = RequestManager()
    private init() {}
    
    func beginRequest<T: Codable, ProvidertType: TargetType>(withTarget target: ProvidertType, model: T.Type, andHandler handler: @escaping (Result<T, Error>)-> Void) {
        print(target, "THIS IS BASE URL 😃")
        print(target.path, "THIS IS PATH URL 😃")
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<ProvidertType>(plugins: [networkLogger])
        
        provider.request(target) { result in
            
            switch result {
            case let .success(response):
                print("success")
                
                //search for range from 200-300
                if (200...299).contains(response.statusCode) {
                    print(result,"success200")
                    
                    do {
                        
                        let model = try JSONDecoder().decode(T.self, from: response.data)
                        print(model, "successHandler 0000")
                        handler(.success(model))
                    }catch let error {
                        handler(.failure(error))
                    }
                }else{
                    do {
                        let model = try JSONDecoder().decode(BaseResponse<ErrorModel>.self, from: response.data)
                        handler(.failure(model.error!))
                        //                        handler(model)
                        
                    } catch let error {
                        print("sdfghgfdsdfghgfdfghG")
                        handler(.failure(error))
                    }
                }
            case let .failure(error):
                print(error,"failure")
                handler(.failure(error))
            }
        }
    }
    //
    func beginRequest<ProviderType: TargetType>(withTarget target: ProviderType, andHandler handler: @escaping (Result<Data, Error>)-> Void) {
        print(target.baseURL, "THIS IS BASE URL 😃")
        print(target.path, "THIS IS PATH URL 😃")
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<ProviderType>(plugins: [networkLogger])
        
        provider.request(target) { result in
            
            switch result {
            case let .success(response):
                print("success")
                
                //search for range from 200-300
                if (200...299).contains(response.statusCode) {
                    print(result,"success200")
                    handler(.success(response.data))
                    
                }else{
                    let error = ErrorModel(message: "XML error")
                    handler(.failure(error))
                }
            case let .failure(error):
                print(error,"failure")
                handler(.failure(error))
            }
        }
    }
}


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
    func beginRequest<T: Codable, ProvidertType: TargetType>(provider: MoyaProvider<ProvidertType>, withTarget target: ProvidertType, model: T.Type, andHandler handler: @escaping (Result<T, Error>)-> Void)

}


class RequestManager: RequestManagerProtocol {
    func beginRequest<T, ProvidertType>(provider: Moya.MoyaProvider<ProvidertType>, withTarget target: ProvidertType, model: T.Type, andHandler handler: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable, ProvidertType : Moya.TargetType {
        print(target, "THIS IS BASE URL 😃")
        print(target.path, "THIS IS PATH URL 😃")
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
//        let provider = MoyaProvider<ProvidertType>(plugins: [networkLogger])
        
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
                        handler(.failure(error))
                    }
                }
            case let .failure(error):
                handler(.failure(error))
            }
        }
    }
    
    
    static let shared = RequestManager()
    
    func beginRequest<T: Codable, ProvidertType: TargetType>(withTarget target: ProvidertType, model: T.Type, andHandler handler: @escaping (Result<T, Error>)-> Void) {
        
    }
}


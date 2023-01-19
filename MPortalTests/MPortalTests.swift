//
//  MPortalTests.swift
//  MPortalTests
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import XCTest
@testable import MPortal
import Moya


final class MPortalTests: XCTestCase {
    
    var homeRemoteManager: HomeRemoteManager!
    
    override func setUp() {
        super.setUp()
        
        let endpointClosure = { (target: HomeAPIs) -> Endpoint in
            let url = URL(target: target).absoluteString
            
            return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        
        var requestManager: RequestManagerProtocol = RequestManager()
        homeRemoteManager = HomeRemoteManager(requestManager: requestManager, provider: MoyaProvider<HomeAPIs>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub))
    }
    
    
    override func tearDown() {
        homeRemoteManager = nil
    }
    
    
    func test_Categories() {
        //Arrange
        let expectation = XCTestExpectation(description: "Get category data successfully")
        
        var categories: BaseResponse<CategoriesData>?
        //Act
        self.homeRemoteManager.getAllCategories { result in
            switch result{
            case .success(let result):
                categories = result
                expectation.fulfill()
            case .failure(let error):
                print(error, "error")
            }
        }
        wait(for: [expectation], timeout: 10)
        
        // Assert
        XCTAssertNotNil(categories)
        XCTAssertEqual(categories?.data?.categories?.count, 13)
        XCTAssertEqual(categories?.data?.categories?.first?.id, 1)
    }
    
    func test_Get_Properties() {
        //Arrange
        let expectation = XCTestExpectation(description: "Get Properties data successfully")
        
        var properties: BaseResponse<[PropertiesModel]>?
        //Act
        
        self.homeRemoteManager.getProperties(cat: "3") { result in
            switch result{
            case .success(let result):
                properties = result
                expectation.fulfill()
            case .failure(let error):
                print(error, "error")
            }
        }
        
        wait(for: [expectation], timeout: 10)
        
        // Assert
        XCTAssertNotNil(properties)
        XCTAssertEqual(properties?.data?.count, 13)
        XCTAssertEqual(properties?.data?.first?.id, 1)
    }
    func test_Get_OptionsChild() {
        //Arrange
        let expectation = XCTestExpectation(description: "Get Options Child data successfully")
        
        var options: BaseResponse<[PropertiesModel]>?
        //Act
        self.homeRemoteManager.getOptionsChild(id: 1){ result in
            switch result{
            case .success(let result):
                options = result
                expectation.fulfill()
            case .failure(let error):
                print(error, "error")
            }
        }
        wait(for: [expectation], timeout: 10)
        
        // Assert
        XCTAssertNotNil(options)
        XCTAssertEqual(options?.data?.count, 1)
        XCTAssertEqual(options?.data?.first?.id, 647)
    }
    
}

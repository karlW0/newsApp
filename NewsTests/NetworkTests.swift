//
//  NetworkTests.swift
//  NewsTests
//
//  Created by Ivan Depolo on 29/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import XCTest
import Alamofire
@testable import News

class NetworkTests: XCTestCase {

    var apiConnector : APIConnectable!

    override func setUp() {
        super.setUp()
        guard
            let info = Bundle.main.infoDictionary,
            let baseURL = info["BASE_URL"] as? String
            else{
                XCTFail("couldn't get base url")
                return
        }
        apiConnector = APIConnector(with: baseURL)
        
    }

    override func tearDown() {
        
    }

    func testgetEverything() {
        let expectation = self.expectation(description: "request should succeed")
        self.apiConnector?.getEverything(with: ["q":"bitcoin"], completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard let total = jsonDict.object(forKey: "totalResults") else {
                    XCTFail("no total object found")
                    return
                }
                print(total)
            case .error(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout:  4, handler: nil)
        
    }
    
    func testGetTopHeadlines() {
        let expectation = self.expectation(description: "request should succeed")
        self.apiConnector?.getTopHeadlines(with: ["country":"us"], completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard let total = jsonDict.object(forKey: "totalResults") else {
                    XCTFail("no total object found")
                    return
                }
                print(total)
            case .error(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout:  4, handler: nil)

    }
    
    func testGetSources() {
        let expectation = self.expectation(description: "request should succeed")
        self.apiConnector?.getSources(with: [:], completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard jsonDict.object(forKey: "sources") != nil else {
                    XCTFail("no sources object found")
                    return
                }
            case .error(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout:  10, handler: nil)
    }

}

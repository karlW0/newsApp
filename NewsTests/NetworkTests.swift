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
    
    fileprivate struct Constants {
        static let baseUrlKey = "BASE_URL"
        static let expectationDescription = "request should succeed"
        static let searchDictEntity = ["q":"bitcoin"]
        static let countryfilterDictEntity = ["country":"us"]
        static let totalResultsKey = "totalResults"
        static let sourcesKey = "sources"
        static let baseUrlFailMsg = "couldn't get base url"
    }

    var apiConnector : APIConnectable!

    override func setUp() {
        super.setUp()
        guard
            let info = Bundle.main.infoDictionary,
            let baseURL = info[Constants.baseUrlKey] as? String
            else{
                XCTFail(Constants.baseUrlFailMsg)
                return
        }
        apiConnector = APIConnector(with: baseURL)
    }

    override func tearDown() {
        apiConnector = nil
    }

    func testgetEverything() {
        let expectation = self.expectation(description: Constants.expectationDescription )
        self.apiConnector?.getEverything(with: Constants.searchDictEntity, completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard let total = jsonDict.object(forKey: Constants.totalResultsKey) else {
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
        let expectation = self.expectation(description: Constants.expectationDescription)
        self.apiConnector?.getTopHeadlines(with: Constants.countryfilterDictEntity , completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard let total = jsonDict.object(forKey: Constants.totalResultsKey) else {
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
        let expectation = self.expectation(description: Constants.expectationDescription)
        self.apiConnector?.getSources(with: [:], completion: { (result) in
            switch result {
            case .success(let json):
                let jsonDict = json as NSDictionary
                guard jsonDict.object(forKey: Constants.sourcesKey) != nil else {
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

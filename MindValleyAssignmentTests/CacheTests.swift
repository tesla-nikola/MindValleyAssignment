//
//  CacheTests.swift
//  MindValleyAssignmentTests
//
//  Created by Soham Ray on 19/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest
@testable import MindValleyAssignment


class CacheTest: XCTestCase {
    private let helper = TestHelper()
    
    override func setUp() {
        
    }

    func testItStoresImageMemory() {
        
        let cache = Cache(name: "CacheTest")
        let image = helper.image
        let key = "SomeRandomKeyName"
        
        let expectation = XCTestExpectation(description: "Cache storing Test")
        cache.store(image, forKey: key)
        
        cache.retrieveImage(forKey: key) { (image) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

    }
    
    func testUnknownCacheKeyReturnNoImage() {
        let cache = Cache(name: "CacheTest")
        let image = helper.image
        let key = "SomeRandomKeyName"
        
        let expectation = XCTestExpectation(description: "Cache storing Test")
        cache.store(image, forKey: key)
        
        cache.retrieveImage(forKey: "WrongKey") { (image) in
            XCTAssertNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func tearDown() {
        
    }
}


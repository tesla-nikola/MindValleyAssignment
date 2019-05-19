//
//  DownloaderTest.swift
//  MindValleyAssignmentTests
//
//  Created by Soham Ray on 19/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest
@testable import MindValleyAssignment
final class DownloaderTests: XCTestCase {
    
    private let url = URL(string: "https://en.wikipedia.org/wiki/Alan_Turing")!
    private let helper = TestHelper()
    
    func testDownload() {
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), self.helper.imageResponseData())
        }
        let configuration = MockURLProtocol.mockedURLSessionConfiguration()
        let downloader = Downloader(sessionConfiguration: configuration)
        
        let expectation = XCTestExpectation(description: "Download Data")
        
        downloader.download(self.url) { (data) in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMultipleDownloads() {
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), self.helper.imageResponseData())
        }
        let configuration = MockURLProtocol.mockedURLSessionConfiguration()
        let downloader = Downloader(sessionConfiguration: configuration)
        
        let expectation1 = XCTestExpectation(description: "Download Data1")
        
        downloader.download(self.url) { (data) in
            XCTAssertNotNil(data)
            expectation1.fulfill()
        }
        
        let expectation2 = XCTestExpectation(description: "Download Data2")
        downloader.download(self.url) { (data) in
            XCTAssertNotNil(data)
            expectation2.fulfill()
        }
        wait(for: [expectation1,expectation2], timeout: 5.0)
        
    }

    func testFailedDownload() {
        MockURLProtocol.requestHandler = { request in
            let anyError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
            throw anyError
        }
        let configuration = MockURLProtocol.mockedURLSessionConfiguration()
        let downloader = Downloader(sessionConfiguration: configuration)
        
        let expectation = XCTestExpectation(description: "Fail Download")

        downloader.download(self.url) { (data) in
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

    }
    
}

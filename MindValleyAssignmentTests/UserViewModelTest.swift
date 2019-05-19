//
//  UserViewModelTest.swift
//  MindValleyAssignmentTests
//
//  Created by Soham Ray on 19/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest
@testable import MindValleyAssignment

class UserViewModelTest: XCTestCase {

    var userVM: UserViewModel!
    
    override func setUp() {
        userVM = UserViewModel()
    }
    
    func testIfViewModelIsNotNil() {
        XCTAssertNotNil(userVM)
    }
    
    func testUserDataDownload() {
        let expectation = XCTestExpectation(description: "User Data Download")
        userVM.getUserData { (status) in
            XCTAssertTrue(status)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    override func tearDown() {
        
    }
    
    

}

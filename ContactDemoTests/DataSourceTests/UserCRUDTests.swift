//
//  ContactDemoTests.swift
//  ContactDemoTests
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import XCTest
@testable import ContactDemo

class ContactDemoTests: XCTestCase {

    var userCRUD: UserCRUD!

    override func setUp() {
        super.setUp()
        self.userCRUD = UserCRUD()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlushUsers() throws {
        let setupExpectation = expectation(description: "flushUsers completion called")
        
        self.userCRUD.flushUsers { (error) in
            XCTAssertNil(error, "Error While Flushing users")
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testAddUsers() throws {
        let setupExpectation = expectation(description: "addUsers completion called")
        
        self.userCRUD.addUsers { (error) in
            XCTAssertNil(error, "Error While adding users")
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchAllUsersOnViewContext() throws {
        let setupExpectation = expectation(description: "completion called")
        
        self.userCRUD.addUsers { (error) in
            XCTAssertNil(error, "Error While adding users")
            self.userCRUD.fetchAllUsersOnViewContext { (users, userFetchError) in
                XCTAssertNil(userFetchError, "Error While Fetching users")
                XCTAssertNotNil(users, "Users Not Found")
                setupExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

//
//  CoreDataControllerTests.swift
//  ContactDemoTests
//
//  Created by Devanshu Saini on 13/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import XCTest
import CoreData
@testable import ContactDemo

class CoreDataControllerTests: XCTestCase {

    var cdController: CoreDataController!
    
    override func setUp() {
        super.setUp()
        self.cdController = CoreDataController()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitializeStack() throws {
        let setupExpectation = expectation(description: "initializeStack completion called")
        
        self.cdController.initializeStack { (_) in
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { (_) in
            XCTAssertTrue(self.cdController.isStoreLoaded, "store not loaded")
        }
    }

}

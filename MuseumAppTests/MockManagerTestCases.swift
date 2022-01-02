//
//  MockManagerTestCases.swift
//  MuseumAppTests
//
//  Created by fahid on 02/01/2022.
//

import XCTest
@testable import MuseumApp

class MockManagerTestCases: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDataFromLocalJSONFile() throws {
        let data = MockNetworkManager.shared.getData(jsonFileName: Endpoint.searchObjects.mockFileName)
        XCTAssertNotNil(data, "Data should not be nil from mock manager when called through endpoints")
    }

    func testGetDataFromLocalJSONFileError() throws {
        let data = MockNetworkManager.shared.getData(jsonFileName: "No file")
        XCTAssertNil(data)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

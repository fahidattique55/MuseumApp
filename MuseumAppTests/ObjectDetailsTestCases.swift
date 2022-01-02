//
//  ObjectDetailsTestCases.swift
//  MuseumAppTests
//
//  Created by fahid on 02/01/2022.
//

import XCTest
@testable import MuseumApp

class ObjectDetailsTestCases: XCTestCase {

    var controller: ObjectDetailsViewController!
    var viewModel: ObjectDetailsViewModel!

    override func setUp() {
        let apiService = MuseumObjectsAPIService(manager: MockNetworkManager.shared)
        let data = MockNetworkManager.shared.getData(jsonFileName: Endpoint.objectDetails(1).mockFileName)
        let object = try! JSONDecoder().decode(ArtObject.self, from: data!)
        viewModel = ObjectDetailsViewModel(apiService: apiService, artObject: object)
        controller = Story.objectDetails.loadViewController(type: ObjectDetailsViewController.self)
        controller.loadViewIfNeeded()
        controller.bind(to: viewModel)
        let keyWindow = UIApplication.shared.keyWindowLatest
        keyWindow?.rootViewController = controller
        RunLoop.main.run(until: Date())
    }

    override func tearDown() {
        controller.viewModel = nil
        controller = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInitialStatesOfViewModel() throws {
        XCTAssertNotNil(viewModel.apiService, "API service is nil for view model")
        XCTAssertNotNil(viewModel.object, "Art Object is nil for view model")
    }
    
    func testTotalImagesCount() throws {
        XCTAssertEqual(viewModel.totalImagesCount, 3, "Images count should be 3 as per local json file.")
    }

    func testDataForRows() throws {
        for type in ObjectDetailsTableViewRowType.allCases {
            let data = viewModel.dataForRowType(type)
            let title = data.0
            let value = data.1
            XCTAssertTrue(!title.isEmpty, "Title for row can not be empty")
            if let rowValue = value {
                XCTAssertTrue(!rowValue.isEmpty, "Value for row can not be empty")
            }
            else {
                XCTAssertNotNil(nil, "Value for row can not be nil")
            }
        }
    }
}

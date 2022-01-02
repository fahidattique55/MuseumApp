//
//  SearchObjectsTestCases.swift
//  MuseumAppTests
//
//  Created by fahid on 02/01/2022.
//

import XCTest
import UIKit
@testable import MuseumApp

class SearchObjectsTestCases: XCTestCase {

    var controller: SearchObjectsViewController!
    var viewModel: SearchObjectsViewModel!

    override func setUp() {
        let apiService = MuseumObjectsAPIService(manager: MockNetworkManager.shared)
        viewModel = SearchObjectsViewModel(apiService: apiService)
        controller = Story.searchObject.loadViewController(type: SearchObjectsViewController.self)
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInitialStatesOfViewModel() throws {
        XCTAssertNotNil(viewModel.apiService, "API service is nil for view model")
        XCTAssertFalse(viewModel.canShowNoResultsFound, "canShowNoResultsFound should be false initially in view model")
        XCTAssertEqual(viewModel.minimumCharactersToTriggerSearch, 3, "minimumCharactersToTriggerSearch should be 3 view model")
        XCTAssertEqual(viewModel.emptyStateMessage.isEmpty, false, "emptyStateMessage can not be empty in view model")
    }

    func testSearchObjectsWithEmptyText() throws {
        let query = ""
        viewModel.searchObjects(searchText: query)
        let searchResults = (try? viewModel.searchResults.value()) ?? []
        XCTAssertTrue(searchResults.isEmpty, "Search results should be empty when search query is empty string.")
    }

    func testSearchObjectsWithLessMinRequiredText() throws {
        let query = "Au"
        viewModel.searchObjects(searchText: query)
        let searchResults = (try? viewModel.searchResults.value()) ?? []
        XCTAssertTrue(searchResults.isEmpty, "Search results should be empty when search query is less than minimum required characters to start search.")
    }

    func testSearchObjects() throws {
        let query = "Aug"
        viewModel.searchObjects(searchText: query)
        let searchResults = (try? self.viewModel.searchResults.value()) ?? []
        XCTAssertTrue(!searchResults.isEmpty, "Search results can not be empty as per local json file in main bundle.")
    }

    func testItemSelectedWithInvalidIndex() throws {
        viewModel.itemSelected(at: -1)
        let objectDetails = try? viewModel.objectDetails.value()
        XCTAssertNil(objectDetails, "Object Details should be nil")
    }

    func testItemSelectedWithNoSearchResults() throws {
        viewModel.itemSelected(at: 2)
        let objectDetails = try? viewModel.objectDetails.value()
        XCTAssertNil(objectDetails, "Object Details should be nil")
    }

    func testItemSelected() throws {
        let query = "Aug"
        viewModel.searchObjects(searchText: query)
        viewModel.itemSelected(at: 0)
        XCTAssertNotNil(viewModel.objectDetails, "Object Details should not be nil")
    }
}

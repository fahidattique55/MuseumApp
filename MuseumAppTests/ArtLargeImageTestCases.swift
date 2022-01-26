//
//  ArtLargeImageTestCases.swift
//  MuseumAppTests
//
//  Created by fahid on 26/01/2022.
//

import Foundation
import XCTest
import UIKit
@testable import MuseumApp

class ArtLargeImageTestCases: XCTestCase {

    var controller: ArtLargeImageViewController!
    var viewModel: ArtLargeImageViewModel!

    override func setUp() {
        viewModel = ArtLargeImageViewModel(imageURL: "https://images.metmuseum.org/CRDImages/dp/original/DP877681.jpg")
        controller = Story.artLargeImage.loadViewController(type: ArtLargeImageViewController.self)
        controller.loadViewIfNeeded()
        controller.bind(to: viewModel)
        let keyWindow = UIApplication.shared.keyWindowLatest
        keyWindow?.rootViewController = controller
        RunLoop.main.run(until: Date())
    }

    override func tearDown() {
        viewModel = nil
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
        XCTAssertNotNil(viewModel.imageURL, "Image URL can not be nil")
    }

    func testImageURLProperty() throws {
        let newImageURL = "testing.com"
        viewModel.imageURL.onNext(newImageURL)
        let viewModelImageURL = try! viewModel.imageURL.value()
        XCTAssertEqual(viewModelImageURL, newImageURL, "New Image URL is not getting set.")
    }
}

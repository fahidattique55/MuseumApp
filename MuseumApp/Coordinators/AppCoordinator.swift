//
//  AppCoordinator.swift
//  MuseumApp
//
//  Created by fahid on 21/12/2021.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorType {
    
    var baseController: UIViewController?
    
    init(with baseController: UIViewController?) {
        self.baseController = baseController
    }
    
    func performTransition(_ transition: Transition) {
        let data = getTransitionData(transition)
        guard let vc = data.controller else { return }
        tranist(to: vc, type: data.type)
    }
    
    func getTransitionData(_ transition: Transition) -> TransitionData {
        switch transition {
        case .searchObject:
            let apiService = MuseumObjectsAPIService(manager: NetworkManager.default)
            let viewModel = SearchObjectsViewModel(apiService: apiService)
            var searchObjectsVC = Story.searchObject.loadViewController(type: SearchObjectsViewController.self)
            searchObjectsVC.bind(to: viewModel)
            let navVC = UINavigationController(rootViewController: searchObjectsVC)
            return TransitionData(controller: navVC, type: .rootWindow)
            
        case .objectDetails(let object):
            let apiService = MuseumObjectsAPIService(manager: NetworkManager.default)
            let viewModel = ObjectDetailsViewModel(apiService: apiService, artObject: object)
            var objectDetailsVC = Story.objectDetails.loadViewController(type: ObjectDetailsViewController.self)
            objectDetailsVC.bind(to: viewModel)
            return TransitionData(controller: objectDetailsVC, type: .push(TransitionOptions.defaultOptions))

        case .artLargeImage(let imageURL):
            let viewModel = ArtLargeImageViewModel(imageURL: imageURL)
            var largeImageVC = Story.artLargeImage.loadViewController(type: ArtLargeImageViewController.self)
            largeImageVC.bind(to: viewModel)
            return TransitionData(controller: largeImageVC, type: .push(TransitionOptions.defaultOptions))

        case .igListKitTest:
            let viewModel = IGListKitTestViewModel()
            var testVC = Story.igListKitTest.loadViewController(type: IGListKitTestViewController.self)
            testVC.bind(to: viewModel)
            return TransitionData(controller: testVC, type: .rootWindow)
        }
    }
}

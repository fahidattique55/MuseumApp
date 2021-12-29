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
        tranist(to: data.controller, type: data.type)
    }
    
    func getTransitionData(_ transition: Transition) -> TransitionData {
        switch transition {
        case .searchObject:
            let apiService = MuseumObjectsAPIService(manager: NetworkManager.default)
            let viewModel = SearchObjectsViewModel(apiService: apiService)
            var searchObjectsVC = Story.searchObject.loadViewController(type: SearchObjectsViewController.self)
            searchObjectsVC.bind(to: viewModel)
            return TransitionData(controller: searchObjectsVC, type: .rootWindow)
        }
    }
}

//
//  Coordinator.swift
//  MuseumApp
//
//  Created by fahid on 21/12/2021.
//

import Foundation
import UIKit


protocol CoordinatorType: AnyObject {
    var baseController: UIViewController? { get }
    func performTransition(_ transition: Transition)
    func getTransitionData(_ transition: Transition) -> TransitionData
}

extension CoordinatorType {
    
    private func applyTransitionOptions(on viewController: UIViewController, type: TransitionType) {
        switch type {
        case .push(let options):
            viewController.hidesBottomBarWhenPushed = options.hidesBottomBarWhenPushed
            break
        case .present(let options):
            viewController.hidesBottomBarWhenPushed = options.hidesBottomBarWhenPushed
            viewController.modalPresentationStyle = options.modalPresentationStyle
            break
        default:
            break
        }
    }
    
    func tranist(to viewController: UIViewController, type: TransitionType) {
        applyTransitionOptions(on: viewController, type: type)
        
        switch type {
        case .push(let options):
            if let navigationController = baseController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: options.animated)
            }
            break
        case .pop(let animated):
            if let navigationController = baseController as? UINavigationController {
                navigationController.popToViewController(viewController, animated: animated)
            }
            break
        case .present(let options):
            baseController?.present(viewController, animated: options.animated, completion: options.completion)
            break
        case .popToRoot(let animated):
            if let navigationController = baseController as? UINavigationController {
                navigationController.popToRootViewController(animated: animated)
            }
            break
        case .rootWindow:
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = viewController
                appDelegate.window?.makeKeyAndVisible()
            }
            break
        default:
            break
        }
    }
}

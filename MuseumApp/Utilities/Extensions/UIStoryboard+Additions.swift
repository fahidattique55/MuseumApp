//
//  UIStoryboard+Additions.swift
//  MuseumApp
//
//  Created by fahid on 21/12/2021.
//

import Foundation
import UIKit

protocol UIStoryboardType {
    var board: UIStoryboard { get }
    var name: String { get }
    func loadViewController<T:UIViewController>(type controller: T.Type) -> T
}

extension UIStoryboardType {
    func loadViewController<T:UIViewController>(type controller: T.Type) -> T {
        if let viewController = board.instantiateViewController(withIdentifier: controller.identifier) as? T {
            return viewController
        }
        fatalError("Can not find controller: \(controller.identifier) in storyboard: \(name)")
    }
}

enum Story: UIStoryboardType {
    
    case searchObject,
         objectDetails,
         artLargeImage,
         igListKitTest
    
    var board: UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
    var name: String {
        switch self {
        case .searchObject:
            return "SearchObjects"
        case .objectDetails:
            return "ObjectDetails"
        case .artLargeImage:
            return "ArtLargeImage"
        case .igListKitTest:
            return "IGListKitTest"
        }
    }
}

//
//  Transition.swift
//  MuseumApp
//
//  Created by fahid on 21/12/2021.
//

import Foundation
import UIKit

struct TransitionData {
    var controller: UIViewController!
    var type: TransitionType!
}

struct TransitionOptions {
    var modalPresentationStyle = UIModalPresentationStyle.fullScreen
    var hidesBottomBarWhenPushed = false
    var completion: (()->Void)? = nil
    var animated: Bool = true
    static let defaultOptions = TransitionOptions(modalPresentationStyle: .fullScreen, hidesBottomBarWhenPushed: true, animated: true)
}

enum TransitionType {
    case present(TransitionOptions),
         push(TransitionOptions),
         pop(Bool),
         popToRoot(Bool),
         rootWindow,
         custom(Any)
}

enum Transition {
    case
    searchObject,
    objectDetails(ArtObject)
}


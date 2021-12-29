//
//  UIAlertController+Additions.swift
//  MuseumApp
//
//  Created by fahid on 29/12/2021.
//

import Foundation
import UIKit

@objc extension UIAlertController {
    static func showAlert(_ error: Error, on controller: UIViewController?) {
        var vc: UIViewController!
        if controller == nil {
            vc = UIViewController.topViewController()!
        }
        else {
            vc = controller
        }
        
        let alertController: UIAlertController = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}


//
//  UIViewController+Additions.swift
//  MuseumApp
//
//  Created by fahid on 29/12/2021.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {

    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindowLatest!.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    func endEditing() {
        view.endEditing(true)
    }
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func showHUD(_ message: String = "")  {
        let size = CGSize(width: 65, height: 65)
        startAnimating(size, message: "", messageFont: UIFont.systemFont(ofSize: 17), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.4), fadeInAnimation: nil)
    }

    func hideHUD()  {
        stopAnimating(nil)
    }
}

//
//  UIApplication+Additions.swift
//  MuseumApp
//
//  Created by fahid on 30/12/2021.
//

import Foundation
import UIKit

extension UIApplication {
    var keyWindowLatest: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}

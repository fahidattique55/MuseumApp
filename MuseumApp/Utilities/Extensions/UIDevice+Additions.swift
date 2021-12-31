//
//  UIDevice+Additions.swift
//  MuseumApp
//
//  Created by fahid on 31/12/2021.
//

import Foundation
import UIKit

extension UIDevice {

    class var hasIphoneXFamilyTopSafeAreaInsets: Bool {
        return safeAreaInsetsTop > 20
    }
    
    class var hasTopSafeAreaInsets: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 0
        }
        return false
    }

    class var safeAreaInsetsTop: CGFloat {
        
        if hasTopSafeAreaInsets {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
        }
        
        return 0
    }

    class var hasBottomSafeAreaInsets: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
    
    class var safeAreaInsetsBottom: CGFloat {
        
        if hasBottomSafeAreaInsets {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        }
        
        return 0
    }
}

//
//  UIImageView+Additions.swift
//  MuseumApp
//
//  Created by fahid on 31/12/2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {

    func setImage(url: String?, placeholder: UIImage? = UIImage(named: "placeholderLarge"), success: ((_ image: UIImage) -> Void)? = nil) {
        guard let urlString = url, !urlString.isEmpty else { return }
        guard let imageURL = URL(string: urlString) else { return }
        self.kf.setImage(with: imageURL, placeholder: placeholder, options: [.transition(.fade(1))]) { result in
            switch result {
            case .success(let result):
                success?(result.image)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

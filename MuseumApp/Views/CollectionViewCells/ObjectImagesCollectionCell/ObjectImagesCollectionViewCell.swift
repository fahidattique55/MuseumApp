//
//  ObjectImagesCollectionViewCell.swift
//  MuseumApp
//
//  Created by fahid on 31/12/2021.
//

import UIKit

class ObjectImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var objectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureImage(url: String) {
        objectImageView.setImage(url: url, success: nil)
    }
}

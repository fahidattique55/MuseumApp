//
//  TestCollectionViewCell.swift
//  MuseumApp
//
//  Created by fahid on 07/02/2022.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: TestModel) {
        testLabel.text = model.lblTitle
        testButton.setTitle(model.btnTitle, for: .normal)
    }
}

//
//  ObjectDetailsSimpleTableViewCell.swift
//  MuseumApp
//
//  Created by fahid on 31/12/2021.
//

import UIKit

class ObjectDetailsSimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var objectDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//
//  StatsViewCell.swift
//  csStats
//
//  Created by Tobias Frantsen on 02/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import UIKit

class StatsViewCell: UICollectionViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(imageName: UIImage?, name: String, value: String) {
        self.imageView.image = imageName
        self.nameLabel.text = name
        self.valueLabel.text = value
    }

}

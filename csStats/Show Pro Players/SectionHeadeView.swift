//
//  SectionHeadeView.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import Nuke
import UIKit

class SectionHeadeView: UICollectionReusableView {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(name: String, logoURL: String) {
        
        self.teamNameLabel.text = name
        if let imageURL = URL(string: logoURL) {

            let options = ImageLoadingOptions( transition: .fadeIn(duration: 0.33),
                                               failureImage: UIImage(named: "unknow"))

            Nuke.loadImage(with: imageURL, options: options, into: self.logoImageView)

        }
    }
    
}

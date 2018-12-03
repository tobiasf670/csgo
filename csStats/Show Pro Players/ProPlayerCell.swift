//
//  ProPlayerCell.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import Nuke
import UIKit

class ProPlayerCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setup(name : String, imageID: String) {
        
        self.nameLabel.text = name
        
        if let imageURL = URL(string: "https://static.hltv.org/images/playerprofile/thumb/\(imageID)/300.jpeg") {
            
            let options = ImageLoadingOptions( transition: .fadeIn(duration: 0.33),
                                               failureImage: UIImage(named: "unknow"))
            
            Nuke.loadImage(with: imageURL, options: options, into: self.profileImageView)
            
        }
        
    }
}

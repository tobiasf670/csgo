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
        self.nameLabel.numberOfLines = 0
    }
    
    func setupCell(imageName: UIImage?, name: String, value: String) {
        self.nameLabel.text = self.getStringAndSetImage(name: name)
        self.valueLabel.text = value
        
    }
    
    func getStringAndSetImage(name:String) -> String {
        var returnString = name
        
        if name == "total_deaths" {
            returnString = "Deaths"
            self.imageView.image = UIImage(named: "death")
        }
        if name == "total_time_played" {
            returnString =  "Playtime"
            self.imageView.image = UIImage(named: "timeplayed")
        }
        if name == "total_planted_bombs" {
            returnString =  "Planted"
            self.imageView.image = UIImage(named: "bombplanted")
        }
        if name == "total_kills_knife" {
            returnString =  "Knife kills"
            self.imageView.image = UIImage(named: "knife")
        }
        if name == "total_kills_glock" {
            returnString =  "Glock kills"
            self.imageView.image = UIImage(named: "glock")
        }
        if name == "total_kills_deagle" {
            returnString =  "Deagle kills"
            self.imageView.image = UIImage(named: "deagle")
        }
        if name == "total_kills_ak47" {
            returnString =  "Ak47 kills"
            self.imageView.image = UIImage(named: "ak47")
        }
        if name == "total_kills_awp" {
            returnString =  "AWP kills"
            self.imageView.image = UIImage(named: "awp")
        }
        if name == "total_kills_aug" {
            returnString =  "AUG kills"
            self.imageView.image = UIImage(named: "aug")
        }
        self.layoutIfNeeded()
        return returnString
        
    }

}

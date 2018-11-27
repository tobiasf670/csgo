//
//  MatchViewCell.swift
//  csStats
//
//  Created by Tobias Frantsen on 27/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import Nuke
import UIKit

enum TeamEnum : String{
    case teamOne
    case teamTwo
    
}

class MatchViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teamOneImageView: UIImageView!
    @IBOutlet weak var teamOneNameLabel: UILabel!
    @IBOutlet weak var teamTwoImageView: UIImageView!
    @IBOutlet weak var teamTwoNameLabel: UILabel!
    @IBOutlet weak var BOLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.teamOneImageView.display(image: nil)
        self.teamTwoImageView.display(image: nil)
        self.timeLabel.text = ""
        self.teamOneNameLabel.text = ""
        self.teamTwoNameLabel.text = ""
        
    }
    
    func setup(time: String, teamOneImage : String, teamTwoImage: String, teamOneName: String, teamTwoName: String, BO: String ) {
//
//        if let timeNumber = Double(time) {
//
//            let _time = timeNumber / 1000
//            let date = Date(timeIntervalSince1970: _time)
//            let formatter = DateFormatter()
//
//            formatter.dateFormat = "MM-dd HH:mm"
//            let stringDate = formatter.string(from: date)
//            self.timeLabel.text = stringDate
//        }
        self.setupTime(time: time)
        
        self.teamOneNameLabel.text = teamOneName
        self.teamTwoNameLabel.text = teamTwoName
        self.BOLabel.text = BO
        
        self.setupImageView(teamOneIdImage: teamOneImage, teamTwoIdImage: teamTwoImage)
        
    }
    
    func setupImageView(teamOneIdImage: String, teamTwoIdImage: String) {
        if let urlTeamOne = URL(string: "https://static.hltv.org/images/team/logo/\(teamOneIdImage)"), let urlTeamTwo = URL(string: "https://static.hltv.org/images/team/logo/\(teamTwoIdImage)") {
            let options = ImageLoadingOptions( transition: .fadeIn(duration: 0.33),
                                               failureImage: UIImage(named: "unknow"))
           
            Nuke.loadImage(with: urlTeamOne, options: options, into: self.teamOneImageView)
            Nuke.loadImage(with: urlTeamTwo, options: options, into: self.teamTwoImageView)
         
        }
       
    }
    
    func setupTime(time: String) {
        if time.isEmpty {
            self.timeLabel.text = "LIVE"
            self.timeLabel.textColor = .green
        } else {
            if let timeNumber = Double(time) {
                self.timeLabel.textColor = .black
                let _time = timeNumber / 1000
                let date = Date(timeIntervalSince1970: _time)
                let formatter = DateFormatter()
                
                formatter.dateFormat = "MM-dd HH:mm"
                let stringDate = formatter.string(from: date)
                self.timeLabel.text = stringDate
            }
        }
      
    }
    
    

}

//
//  MatchModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 27/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import SwiftyJSON
import UIKit


class MatchModel {
    var time: String?
    var teamOneImage: String?
    var teamOneName: String?
    var teamTwoImage: String?
    var teamTwoName: String?
    var BO: String?
    
    init(time: String?, teamOneImage: String?, teamOneName: String?, teamTwoImage: String?, teamTwoName: String?, BO: String?  ) {
       
        self.time = time
        self.teamOneImage = teamOneImage
        self.teamOneName = teamOneName
        self.teamTwoImage = teamTwoImage
        self.teamTwoName = teamTwoName
        self.BO = BO
        
    }
    
    class func parse(json: JSON) -> [MatchModel] {
       var matchArray : [MatchModel] = [MatchModel]()
        for games in json {
            let time =   games.1["date"].stringValue
            let teamOne = games.1["team1"]["name"].stringValue
            let teamOneImageID =  games.1["team1"]["id"].stringValue
            let teamTwo = games.1["team2"]["name"].stringValue
            let teamTwoImageID = games.1["team2"]["id"].stringValue
            let format = games.1["format"].stringValue
            
            
            if !teamOne.isEmpty && !teamTwo.isEmpty {
                let newObject = MatchModel(time: time, teamOneImage: teamOneImageID, teamOneName: teamOne, teamTwoImage: teamTwoImageID, teamTwoName: teamTwo, BO: format)
                matchArray.append(newObject)
            }
           
        }
        return matchArray
    }
}

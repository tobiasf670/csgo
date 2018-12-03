//
//  TeamModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import SwiftyJSON
import UIKit


class TeamModel {
    var name: String?
    var logo: String?
    var players: [ProPlayerModel]
    
    init(name: String?, logo: String?, players: [ProPlayerModel] ) {
        self.name = name
        self.logo = logo
        self.players = players
        
   
    }
    
    class func parse(json: JSON) -> TeamModel  {
        var playerArray : [ProPlayerModel] = [ProPlayerModel]()
        
        let name = json["name"].stringValue
        let logo = json["logo"].stringValue
        let players = json["players"].arrayValue

       
        for player in players {
            let name = player["name"].stringValue
            let id = player["id"].stringValue
            let newProPlayerObject = ProPlayerModel(name: name, id: id)
            playerArray.append(newProPlayerObject)
        }
        let teamObject = TeamModel(name: name, logo: logo, players: playerArray)
        return teamObject
    }
}

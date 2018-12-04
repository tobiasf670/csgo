//
//  TeamModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RealmSwift
import SwiftyJSON
import UIKit


class TeamModel: Object {
    @objc dynamic var teamId = NSUUID().uuidString
    @objc dynamic var name: String?
    @objc dynamic var logo: String?
//     var players: [ProPlayerModel] = []
    var players = List<ProPlayerModel>()
    
   convenience init(name: String?, logo: String?, players: List<ProPlayerModel> ) {
        self.init()
        self.name = name
        self.logo = logo
        self.players = players
        
   
    }
    
    override class func primaryKey() -> String? {
        return "teamId"
    }
    
    class func parse(json: JSON) -> TeamModel  {
//        var playerArray : [ProPlayerModel] = [ProPlayerModel]()
        let playerArray = List<ProPlayerModel>()
        
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

//
//  SteamModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 01/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import SwiftyJSON
import UIKit

class SteamModel {
    var name: String?
    var value: Int?
    init(name: String?, value: Int?) {
        self.name = name
        self.value = value
    }
    
    class func parse(json: JSON) -> [SteamModel] {
        let statsArray = json["playerstats"]["stats"]
        
        
        var testArray : [SteamModel] = [SteamModel]()
        for stats in statsArray {
            if let name = stats.1["name"].string, let value = stats.1["value"].int {
                let newObject = SteamModel(name: name, value: value)
                testArray.append(newObject)
            }
        }
        
        return testArray
    }
}


// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

class Welcome: Codable {
    let playerstats: Playerstats
    
    init(playerstats: Playerstats) {
        self.playerstats = playerstats
    }
}

class Playerstats: Codable {
    let steamID, gameName: String
    let stats: [Stat]
    let achievements: [Achievement]
    
    init(steamID: String, gameName: String, stats: [Stat], achievements: [Achievement]) {
        self.steamID = steamID
        self.gameName = gameName
        self.stats = stats
        self.achievements = achievements
    }
}

class Achievement: Codable {
    let name: String
    let achieved: Int
    
    init(name: String, achieved: Int) {
        self.name = name
        self.achieved = achieved
    }
}

class Stat: Codable {
    let name: String
    let value: Int
    
    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
}

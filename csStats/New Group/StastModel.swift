//
//  SteamModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 01/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RealmSwift
import SwiftyJSON
import UIKit

class StastModel: Object {
    @objc dynamic var statsId = NSUUID().uuidString
    @objc dynamic var name: String?
    var value = RealmOptional<Int>()
    
   convenience init(name: String?, value: Int?) {
        self.init()
        self.name = name
        self.value.value = value
    }
    
    override class func primaryKey() -> String? {
        return "statsId"
    }
    
    
    class func parse(json: JSON) -> [StastModel] {
        let statsArray = json["playerstats"]["stats"]
        
        
        var _statsArray : [StastModel] = [StastModel]()
        for stats in statsArray {
            if let name = stats.1["name"].string, let value = stats.1["value"].int {
                let newObject = StastModel(name: name, value: value)
                _statsArray.append(newObject)
            }
        }
        
        return _statsArray
    }
}


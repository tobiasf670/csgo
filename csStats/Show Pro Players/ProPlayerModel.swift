//
//  ProPlayerModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class ProPlayerModel: Object {
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    
    
    convenience init(name: String?, id: String? ) {
        self.init()
        self.name = name
        self.id = id
    }
    
    override class func primaryKey() -> String? {
                return "id"
            }
}

//import Foundation
//import UIKit
//import RealmSwift
//
//class Chair: Object {
//
//    @objc dynamic var chairId = NSUUID().uuidString
//    @objc dynamic var name = "Name"
//    @objc dynamic var designer = "Designer"
//
//
//    convenience init(name: String, designer: String) {
//        self.init()
//        if !name.isEmpty {
//            self.name = name
//        }
//        if !designer.isEmpty {
//            self.designer = designer
//        }
//    }
//
//    override class func primaryKey() -> String? {
//        return "chairId"
//    }
//
//    override class func indexedProperties() -> [String] {
//        return ["name"]
//    }
//
//}

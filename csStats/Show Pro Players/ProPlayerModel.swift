//
//  ProPlayerModel.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import Foundation
import UIKit

class ProPlayerModel {
    var name: String?
    var id: String?
    
    
    init(name: String?, id: String? ) {
        self.name = name
        self.id = id
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func getId() -> String? {
        return self.id
    }
}

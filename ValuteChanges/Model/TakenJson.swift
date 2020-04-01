//
//  TakenJson.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import ObjectMapper

class TakenJson: Mappable{
    var valutes: [String: Valute] = [:]
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        valutes <- map["Valute"]
    }
}





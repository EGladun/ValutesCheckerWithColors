//
//  Valute.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import ObjectMapper

class Valute: Mappable{
    
    var id: String?
    var numCode: String?
    var charCode: String?
    var nominal: Int?
    var name: String?
    var value: Double?
    var previous: Double?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["ID"]
        numCode <- map["NumCode"]
        charCode <- map["CharCode"]
        nominal <- map["Nominal"]
        name <- map["Name"]
        value <- map["Value"]
        previous <- map["Previous"]
    }
    
    
}

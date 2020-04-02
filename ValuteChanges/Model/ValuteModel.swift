//
//  ValuteModel.swift
//  ValuteChanges
//
//  Created by Egor on 02.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import RealmSwift

class ValuteModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var numCode: String = ""
    @objc dynamic var charCode: String = ""
    @objc dynamic var nominal: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var value: Double = 0.0
    @objc dynamic var previous: Double = 0.0
}

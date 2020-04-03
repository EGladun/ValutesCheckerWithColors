//
//  CollectionCellViewModel.swift
//  ValuteChanges
//
//  Created by Egor on 03.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

class CollectionCellViewModel {
    
    var codeText: String!
    var rateText: String!
    var nominal: Int!
    
    required init(item: ValuteModel) {
        self.codeText = item.charCode
        self.rateText = String(item.value)
        self.nominal = item.nominal
    }
    
}

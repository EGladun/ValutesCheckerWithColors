//
//  ValutesCellViewModel.swift
//  ValuteChanges
//
//  Created by Egor on 03.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import UIKit

class ValutesCellViewModel {
    var codeText: String!
    var valueText: String!
    var previousText: String!
    var changeText: String!
    var color: UIColor!
    
    required init(item: Valute) {
        self.codeText = item.charCode!
        self.valueText = String(item.value!)
        self.previousText = String(item.previous!)
        let change = item.value! - item.previous!
        self.changeText = String(change)
        
        if change >= 0 {
            self.color = .green
        } else {
            self.color = .red
        }
        
    }
}

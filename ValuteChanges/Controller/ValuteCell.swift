//
//  ValuteCell.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ValuteCell: UITableViewCell {
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var previousLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

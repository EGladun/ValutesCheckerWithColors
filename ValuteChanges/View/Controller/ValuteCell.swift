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
    
    weak var viewModel: ValutesCellViewModel! {
        didSet {
            self.codeLabel.text = viewModel.codeText
            self.valueLabel.text = viewModel.valueText
            self.previousLabel.text = viewModel.previousText
            self.changeLabel.text = viewModel.changeText
            
            self.backgroundColor = viewModel.color
        }
    }

    
}

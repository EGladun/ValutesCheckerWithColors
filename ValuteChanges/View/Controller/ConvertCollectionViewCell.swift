//
//  ConvertCollectionViewCell.swift
//  ValuteChanges
//
//  Created by Egor on 02.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ConvertCollectionViewCell: UICollectionViewCell {
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    var nominal: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    weak var viewModel: CollectionCellViewModel! {
        didSet {
            self.codeLabel.text = viewModel.codeText
            self.rateLabel.text = viewModel.rateText
            self.nominal = viewModel.nominal
        }
    }

}

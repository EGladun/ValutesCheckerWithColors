//
//  SecondViewController.swift
//  ValuteChanges
//
//  Created by Egor on 02.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import RealmSwift
import Bond

class SecondViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var rubLabel: UILabel!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var rubTextField: UITextField!
    @IBOutlet var otherTextField: UITextField!
    
    let viewModel = ConverterViewModel()
    
    
    let nib = UINib(nibName: "ConvertCollectionViewCell", bundle: nil)
    let identifier = "MyCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convert"
        
        self.updateOtherLabel()
        self.setUpCollectionView()
        self.setUpTextFields()
        
        self.viewModel.updateCollectionData()
        
    }
    
    func setUpCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(self.nib, forCellWithReuseIdentifier: self.identifier)
        
        self.collectionView.reloadData()
    }
    
    func setUpTextFields() {
        self.rubTextField.reactive.text.observeNext { (text) in
            self.otherTextField.text = self.viewModel.convertFromRub(arg: text)
        }
        
        self.otherTextField.reactive.text.observeNext { (text) in
            self.rubTextField.text = self.viewModel.convertToRub(arg: text)
        }
    }

    @IBAction func closeKBButton(_ sender: Any) {
        self.rubTextField.endEditing(true)
        self.otherTextField.endEditing(true)
    }
    
    func updateOtherLabel() {
        self.otherLabel.text = self.viewModel.takeCode()
        if let value = self.rubTextField.text {
            let rubValue = (value as NSString).doubleValue
            self.otherTextField.text = String(rubValue / self.viewModel.takeRate())
        }
    }
    
    
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.numberOfItems() != 0 {
            return self.viewModel.numberOfItems()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! ConvertCollectionViewCell
        cell.viewModel = self.viewModel.cellViewModel(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.updateConvertValue(index: indexPath.row)
        self.updateOtherLabel()
        
    }
    
    
}

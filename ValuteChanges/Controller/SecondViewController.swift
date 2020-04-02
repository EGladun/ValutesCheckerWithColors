//
//  SecondViewController.swift
//  ValuteChanges
//
//  Created by Egor on 02.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var rubLabel: UILabel!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var rubTextField: UITextField!
    @IBOutlet var otherTextField: UITextField!
    
    let realm = try! Realm()
    var collectionArray: Results<ValuteModel>!
    let nib = UINib(nibName: "ConvertCollectionViewCell", bundle: nil)
    let identifier = "MyCell"
    
    var rate: Double = 1
    var code = "RUB"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convert"
        
        self.updateOtherLabel()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(self.nib, forCellWithReuseIdentifier: self.identifier)
        
        self.collectionArray = realm.objects(ValuteModel.self)
        self.collectionView.reloadData()
        
        self.rubTextField.addTarget(self, action: #selector(self.converterRub), for: .editingChanged)
        
        self.otherTextField.addTarget(self, action: #selector(self.converterToRub), for: .editingChanged)
        
    }

    @IBAction func closeKBButton(_ sender: Any) {
        self.rubTextField.endEditing(true)
        self.otherTextField.endEditing(true)
    }
    
    func updateOtherLabel() {
        self.otherLabel.text = self.code
        print(self.code)
        print(self.rate)
    }
    
    @objc func converterRub() {
        if let value = self.rubTextField.text {
            let rubValue = (value as NSString).doubleValue
            self.otherTextField.text = String(rubValue / self.rate)
        }
    }
    
    @objc func converterToRub() {
        if let value = self.otherTextField.text {
            let valValue = (value as NSString).doubleValue
            self.rubTextField.text = String(valValue * self.rate)
        }
    }
    
    
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionArray.count != 0 {
            return self.collectionArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! ConvertCollectionViewCell
        let item = self.collectionArray[indexPath.row]
        cell.codeLabel.text = item.charCode
        cell.rateLabel.text = String(item.value)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.code = self.collectionArray[indexPath.row].charCode
        self.rate = self.collectionArray[indexPath.row].value
        self.updateOtherLabel()
    }
    
    
}

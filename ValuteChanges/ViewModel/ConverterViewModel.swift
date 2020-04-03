//
//  ConverterViewModel.swift
//  ValuteChanges
//
//  Created by Egor on 03.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import RealmSwift

class ConverterViewModel {
    
    let realm = try! Realm()
    var collectionArray: Results<ValuteModel>!
    private var cellsArray = [CollectionCellViewModel]()
    var rate: Double = 1
    var code = "RUB"
    
    func updateCollectionData() {
        
        self.collectionArray = realm.objects(ValuteModel.self)
        self.collectionArray.forEach({ (arg0) in
            self.cellsArray.append(CollectionCellViewModel(item: arg0))
        })
        
    }
    
    func takeCode() -> String{
        return self.code
    }
    
    func takeRate() -> Double{
        return self.rate
    }
    
    func convertFromRub(arg: String?) -> String{
        if let value = arg {
            let rubValue = (value as NSString).doubleValue
            return String(rubValue / self.rate)
        }
        return "0"
    }
    
    func convertToRub(arg: String?) -> String{
        if let value = arg {
            let valValue = (value as NSString).doubleValue
            return String(valValue * self.rate)
        }
        return "0"
    }
    
    func numberOfItems() -> Int {
        return self.collectionArray.count
    }
    
    func cellViewModel(index: Int) -> CollectionCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
    
    func updateConvertValue(index: Int) {
        self.code = self.collectionArray[index].charCode
        self.rate = self.collectionArray[index].value
    }
}

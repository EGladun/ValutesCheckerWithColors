//
//  StartViewModel.swift
//  ValuteChanges
//
//  Created by Egor on 03.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import RealmSwift

class StartViewModel {
    
    var valutesArray: [Valute] = []
    private var cellsArray = [ValutesCellViewModel]()
    private var searchingCellsArray = [ValutesCellViewModel]()
    let parser = Parser()
    var searchValute: [Valute] = []
    let realm = try! Realm()
    
    func updateValutes(completion: @escaping() -> Void) {
        self.cellsArray.removeAll()
        
        self.parser.doRequest {
            self.valutesArray = self.parser.valutesArray
        
            self.valutesArray.forEach({ (arg0) in
                self.cellsArray.append(ValutesCellViewModel(item: arg0))
            })
            
            try! self.realm.write {
                self.realm.deleteAll()
            }
            self.saveToRealm()
            completion()
        }
        
        
        
    }
    
    func saveToRealm() {
        
        self.valutesArray.forEach({ (arg0) in
            let currentValute = ValuteModel()
            currentValute.id = arg0.id!
            currentValute.numCode = arg0.numCode!
            currentValute.charCode = arg0.charCode!
            currentValute.nominal = arg0.nominal!
            currentValute.name = arg0.name!
            currentValute.value = arg0.value!
            currentValute.previous = arg0.previous!
            
            try! realm.write {
                realm.add(currentValute)
            }
        })
    }
    
    func numberOfValutes() -> Int {
        return self.valutesArray.count
    }
    
    func numberOfSearchingValutes() -> Int {
        return self.searchValute.count
    }
    
    func cellViewModel(index: Int) -> ValutesCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
    
    func searchingCellViewModel(index: Int) -> ValutesCellViewModel? {
        guard index < searchingCellsArray.count else { return nil }
        return searchingCellsArray[index]
    }
    
    func search(arg: String, completion: @escaping() -> Void) {
        self.searchValute.removeAll()
        self.searchingCellsArray.removeAll()
       self.searchValute = self.valutesArray.filter({
        ($0.charCode?.lowercased().prefix(arg.count).elementsEqual(arg.lowercased()))!
       })
        self.searchValute.forEach { (arg0) in
            self.searchingCellsArray.append(ValutesCellViewModel(item: arg0))
        }
        completion()
    }
    
}

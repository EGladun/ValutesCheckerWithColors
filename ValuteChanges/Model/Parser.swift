//
//  Parser.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Parser {
    
    var valutesArray: [Valute] = []
    
    func doRequest(completion: @escaping() -> Void) {
        AF.request("https://www.cbr-xml-daily.ru/daily_json.js").validate().responseObject { (response: AFDataResponse<TakenJson>) in
            print("Parsing...")
            switch response.result{
            case .success(let value):
                let takenJson = TakenJson()
                takenJson.valutes = value.valutes
                takenJson.valutes.forEach({ (arg0) in
                    self.valutesArray.append(arg0.value)
                })
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
        
    }
    
}

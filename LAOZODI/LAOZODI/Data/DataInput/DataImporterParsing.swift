//
//  DataImporterParsing.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/11/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation

class DataSetting{
    
    struct Obj: Decodable{
        let name: String?
    }
    public static func readDataFormImportFile(){
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["name"] as? [Any] {
                    // do stuff
                    print("############################PERSON : \(person)")
                }
            } catch {
                // handle error
            }
        }
        
    }
}

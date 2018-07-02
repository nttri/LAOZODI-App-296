//
//  Product.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/27/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation

class Product{
    var identifier : Int
    var name: String
    var description : String
    var price : Int
    var brand : String
    var strURLImage : String
    var warranty: Int
    var xyz = "product from branch"
    
    init(Identifier _identifier :Int, Name _name: String, Description _description:String, Price _price: Int,
         Brand _brand:String, StrURLImage _strURLImage: String, Warranty _waranty: Int){
        self.identifier = _identifier
        self.name = _name
        self.description = _description
        self.price = _price
        self.brand = _brand
        self.strURLImage = _strURLImage
        self.warranty = _waranty
    }
    
    init(){
        self.identifier = -1
        self.name = "nil"
        self.description = "nil"
        self.price = -1
        self.brand = "nil"
        self.strURLImage = "nil"
        self.warranty = -1
    }
    
    
    
}

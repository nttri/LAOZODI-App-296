//
//  CartProduct.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/10/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation

public class ProductInCartObject{
    var product: Product? = Product()
    var number: Int = 0
    
    init(Product _product: Product, Amount _amount : Int) {
        self.product  = _product
        self.number = _amount
    }
}

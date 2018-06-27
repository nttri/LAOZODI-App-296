//
//  OrderObject.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/25/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation
public class OrderObject{
    public var orderNumber : Int
    public var orderInfo: String
    
    init(OrderNumber _orderNumber: Int, OrderInfo _orderInfo: String) {
        self.orderNumber = _orderNumber
        self.orderInfo = _orderInfo
    }
}

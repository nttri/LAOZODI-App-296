//
//  UIViewExtensions.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/28/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

extension UIView{
    func makeShadowAnimation(){
        self.clipsToBounds = false
        self.layer.cornerRadius = 14
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

//
//  User.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/29/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation

class User {
    var email: String
    var name: String
    var birthday: String
    var gender: String
    var password: String
    
    init(name: String?, email: String?, birthday: String?, gender: String?, pass: String?){
        self.email = email ?? "email"
        self.name = name ?? ""
        self.birthday = birthday ?? ""
        self.gender = gender ?? ""
        self.password = pass ?? ""
    }
    
    init(){
        self.email = ""
        self.name = "name"
        self.birthday = ""
        self.gender = ""
        self.password = ""
    }
}

class CurrentUser {
    
    static let shared = CurrentUser()
    private var user = User()
    
    private init(){ }
    
    func setUser(_ user: User){
        self.user = user
    }
    
    func getUser() -> User{
        return self.user
    }
    
}

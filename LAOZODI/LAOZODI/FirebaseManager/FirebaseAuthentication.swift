//
//  FirebaseAuthentication.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/29/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol AlertDelegate: class {
    func showAlert(_ title:String?,_ content:String?)
}

class FirebaseAuthenAPI{
    
    weak var delegate: AlertDelegate?
    
    static let sharedInstance = FirebaseAuthenAPI()
    
    private init(){}
    
    //MARK - create account method
    func createAccount(_user: User, screen:UIViewController){
        Auth.auth().createUser(withEmail: _user.email, password: _user.password) { (user, error) in
            if error == nil{
                FirebaseManager.shared.addUserToFirebase(user: _user)
                //self.delegate?.showAlert("ĐĂNG KÝ THÀNH CÔNG!", "")
                print("Đăng ký thành công")
            }else{
                self.delegate?.showAlert("CẢNH BÁO!", error?.localizedDescription)
                print("Đăng ký thất bại")
            }
        }
    }
    
    //MARK - login method
    func login(_ email:String,_ password: String, screen:UIViewController){
        let user = User(name: "", email: email, birthday: "", gender: "", pass: password)
        FirebaseManager.shared.makeUserOnline(user: user, screen: screen)
    }
    
    //MARK - logout method
    func logout(){
        UserDefaults.standard.removeObject(forKey: "Email")
        UserDefaults.standard.removeObject(forKey: "Password")
    }
    
}

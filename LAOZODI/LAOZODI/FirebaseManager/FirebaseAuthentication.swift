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
    
    //MARK - create account method
    func createAccount(_ email:String,_ password: String, screen:UIViewController){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                self.delegate?.showAlert("ĐĂNG KÝ THÀNH CÔNG!", "")
                print("Đăng ký thành công")
            }else{
                self.delegate?.showAlert("CẢNH BÁO!", error?.localizedDescription)
                print("Đăng ký thất bại")
            }
        }
    }
    
    //MARK - login method
    func login(_ email:String,_ password: String, screen:UIViewController){
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                screen.performSegue(withIdentifier: "showHomeViewControllerSegue", sender: self)
                UserDefaults.standard.set(email, forKey: "Email")
                UserDefaults.standard.set(password, forKey: "Password")
                print("Đăng nhập thành công")
            }else{
                self.delegate?.showAlert("CẢNH BÁO!", error?.localizedDescription)
                print("Đăng nhập thất bại")
            }
        })
    }
    
    //MARK - logout method
    func logout(){
        do{
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "Email")
            UserDefaults.standard.removeObject(forKey: "Password")
            print("Đăng xuất thành công")
        } catch {
            print("Đăng xuất thất bại")
            return
        }
    }
    
}

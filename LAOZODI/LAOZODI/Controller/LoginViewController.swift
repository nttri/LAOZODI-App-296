//
//  LoginViewController.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/29/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AlertDelegate {
    
    var screenHeight:CGFloat = 0
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseAuthenAPI.sharedInstance.delegate = self
        autoLogin()
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: config func
    private func updateUI(){
        self.screenHeight = UIScreen.main.bounds.height
        appTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: self.screenHeight*0.17).isActive = true
        btnRegister.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.screenHeight*(-0.12)).isActive = true
    }
    
    @IBAction func loginTouched(_ sender: Any) {
        let email:String? = emailField.text
        let password:String? = passwordField.text
        FirebaseAuthenAPI.sharedInstance.login(email!, password!, screen: self)
    }
    
    @IBAction func registerTouched(_ sender: Any) {
        let email:String? = emailField.text
        let password:String? = passwordField.text
        FirebaseAuthenAPI.sharedInstance.createAccount(email!,password!, screen: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHomeViewControllerSegue"{
            let viewController = segue.destination as! UITabBarController
        }
    }
    
    // auto signin if the user account still active
    func autoLogin(){
        if let email = UserDefaults.standard.value(forKey: "Email") as? String, let password = UserDefaults.standard.value(forKey: "Password") as? String{
            print(email)
            FirebaseAuthenAPI.sharedInstance.login(email, password, screen: self)
        }
    }
    
    // add unwind segue
    @IBAction func backToHome(segue: UIStoryboardSegue){}
    
    // implement protocol
    func showAlert(_ title: String?, _ content: String?) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

//
//  RegisterVC.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 7/1/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var smGender: UISegmentedControl!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegisterTouched(_ sender: Any) {
        let email = tfEmail.text ?? ""
        let password = tfPassword.text ?? ""
        let name = tfName.text ?? ""
        let birthday = tfBirthday.text ?? ""
        let genderIndex:Int = smGender.selectedSegmentIndex
        let gender = genderIndex == 0 ? "Nam" : "Nữ"
        if(email == "" || password == "" || name == "" || birthday == ""){
            let alert = UIAlertController(title: "CẢNH BÁO", message: "Vui lòng điền đầy đủ các thông tin yêu cầu!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let user = User(name: name, email: email, birthday: birthday, gender: gender, pass: password)
            FirebaseAuthenAPI.sharedInstance.createAccount(_user: user, screen: self)
            self.performSegue(withIdentifier: "backToHomeFromRegister", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToHomeFromRegister"){
            if let vc = segue.destination as? LoginViewController{
                let email = tfEmail.text ?? ""
                let password = tfPassword.text ?? ""
                vc.tempEmail = email
                vc.tempPW = password
            }
        }
    }
    
}

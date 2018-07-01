//
//  AccountInfoEditTVC.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/30/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class AccountInfoEditTVC: UITableViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var sexBox: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.tfName.frame.height))
        tfName.leftView = paddingView
        tfName.leftViewMode = UITextFieldViewMode.always
        paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.tfBirthday.frame.height))
        tfBirthday.leftView = paddingView
        tfBirthday.leftViewMode = UITextFieldViewMode.always
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        let user = CurrentUser.shared.getUser()
        tfName.text = user.name
        lblEmail.text = user.email
        tfBirthday.text = user.birthday
        if(user.gender == "Nữ"){
            sexBox.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func btnUpdateInfoTouched(_ sender: Any) {
        let email = lblEmail.text
        let name = tfName.text
        let birthday = tfBirthday.text
        let gender = sexBox.selectedSegmentIndex == 0 ? "Nam" : "Nữ"
        let password = CurrentUser.shared.getUser().password
        
        if(name == "" || birthday == ""){
            let alert = UIAlertController(title: "CẢNH BÁO", message: "Vui lòng điền đầy đủ các thông tin yêu cầu!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let user = User(name: name, email: email, birthday: birthday, gender: gender, pass: password)
            FirebaseManager.shared.updateUserInfo(user: user)
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    

}

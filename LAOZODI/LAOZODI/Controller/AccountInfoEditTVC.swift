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
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.tfName.frame.height))
        tfName.leftView = paddingView
        tfName.leftViewMode = UITextFieldViewMode.always
        paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.tfBirthday.frame.height))
        tfBirthday.leftView = paddingView
        tfBirthday.leftViewMode = UITextFieldViewMode.always
        
        createDatePicker()
        tfName.delegate = self
        tfBirthday.delegate = self
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
    
    func createDatePicker(){
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        toolbar.setItems([cancel,done], animated: false)
        
        tfBirthday.inputAccessoryView = toolbar
        tfBirthday.inputView = datePicker
        
        // format picker for date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date.init(timeIntervalSince1970: -1576800000)
        datePicker.maximumDate = Date.init(timeIntervalSince1970: 1009190000)
    }
    
    @objc func donePressed(){
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let dateStr = formatter.string(from: datePicker.date)
        
        tfBirthday.text = "\(dateStr)"
        self.view.endEditing(true)
    }
    
    @objc func cancelPressed(){
        self.view.endEditing(true)
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
            CurrentUser.shared.getUser().name = user.name
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension AccountInfoEditTVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tfName.resignFirstResponder()
        tfBirthday.resignFirstResponder()
    }
    
}


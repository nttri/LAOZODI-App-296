//
//  PaymentProductViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/10/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

fileprivate class PickerViewTagIndentifier {
    public static let CITY_PICKER_VIEW_TAG = 1
    public static let DISTRICT_PICKER_VIEW_TAG = 2
    public static let WARD_PICKER_VIEW_TAG = 3
    public static let STREET_PICKER_VIEW_TAG = 4
}
class PaymentProductViewController: UIViewController {

    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var tfWard: UITextField!
    @IBOutlet weak var tfDistrict: UITextField!
    @IBOutlet weak var tfHomeNumber: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    
    let cityPickerView = UIPickerView()
    let districtPicketView = UIPickerView()
    let wardPickerView = UIPickerView()
    let strictPickerView = UIPickerView()
    
    let citiesData = ["Hà Nội","Hà Giang","Cao Bằng","Bắc Kạn","Tuyên Quang","Lào Cai","Điện Biên","Lai Châu","Sơn La","Yên Bái","Hòa Bình","Thái Nguyên","Lạng Sơn","Quảng Ninh","Bắc Giang","Phú Thọ","Vĩnh Phúc","Bắc Ninh","Hải Dương","Hải Phòng","Hưng Yên","Thái Bình","Hà Nam","Nam Định","Ninh Bình","Thanh Hóa","Nghệ An","Hà Tĩnh","Quảng Bình","Quảng Trị","Thừa Thiên Huế","Đà Nẵng","Quảng Nam","Quảng Ngãi","Bình Định","Phú Yên","Khánh Hòa","Ninh Thuận","Bình Thuận","Kon Tum","Gia Lai","Đắk Lắk","Đắk Nông","Lâm Đồng","Bình Phước","Tây Ninh","Bình Dương","Đồng Nai","Bà Rịa - Vũng Tàu","Hồ Chí Minh","Long An","Tiền Giang","Bến Tre","Trà Vinh","Vĩnh Long","Đồng Tháp","An Giang","Kiên Giang","Cần Thơ","Hậu Giang","Sóc Trăng","Bạc Liêu","Cà Mau"];
    
    @IBOutlet weak var btnPayment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        btnPayment.setGradientBackground(colorOne: UIColor(red: 0.21, green: 0.82, blue: 0.86, alpha: 1), colorTwo: UIColor(red: 0.36, green: 0.53, blue: 0.9, alpha: 1))
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
        districtPicketView.delegate = self
        districtPicketView.dataSource = self
        
        wardPickerView.delegate = self
        wardPickerView.dataSource  = self
        
        strictPickerView.delegate = self
        strictPickerView.dataSource = self
        updateUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBtnPaymentClick(_ sender: Any) {
        if(checkIsValidData()){
            FirebaseManager.shared.databaseReference.child(AppCons.OrderGroup.ORDER).child(AppCons.OrderGroup.CURRENT_NUMBER).observeSingleEvent(of: .value, with: {(snapShot) in
                let currentOrderNumber = snapShot.value as! Int
                let orderInfo = self.getOrderInfo()
                let orderObject: OrderObject = OrderObject(OrderNumber: currentOrderNumber + 1, OrderInfo: orderInfo)
                FirebaseManager.shared.addOrderObject(OrderObject: orderObject)
                let alertController = UIAlertController(title: "THôNG BÁO", message: "Đơn hàng số \(currentOrderNumber + 1) của bạn đang được xử lý", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alertController, animated: true,completion: nil)
                self.tabBarController?.selectedIndex = 0
            })
        }
    }
    
    
    func checkIsValidData() -> Bool{
        return true;
    }
    
    
    func getOrderInfo() ->String{
        let city = tfCity.text!
        let district = tfDistrict.text!
        let ward = tfWard.text!
        let street = tfStreet.text!
        let name = tfName.text!
        let phoneNumber = tfPhoneNumber.text!
        let homeNumber = tfHomeNumber.text!
        
        
        return "Thông tin người nhận Họ tên : \(name), số điện thoại: \(phoneNumber) , địa chỉ : \(homeNumber) - đường \(street) - phường/xã \(ward) - quận/huyện \(district) - tỉnh/tp  \(city)"
    }
    func sendEmailNotification(){
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PaymentProductViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG:
            return citiesData.count
        default:
            return -1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG:
            return citiesData[row]
        default:
            return ""
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG:
            tfCity.text = citiesData[row]
        default:
            print("not valid value")
        }
    }
    
}


extension PaymentProductViewController{
    func createPickerView(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //create bar button item for toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(btnDonePressed))
        toolbar.setItems([doneButton], animated: true)
        
        tfCity.inputAccessoryView = toolbar
        tfCity.inputView = cityPickerView
        
        tfDistrict.inputAccessoryView = toolbar
        tfDistrict.inputView = districtPicketView
        
        tfWard.inputAccessoryView = toolbar
        tfWard.inputView = wardPickerView
        
        tfStreet.inputAccessoryView = toolbar
        tfStreet.inputView = strictPickerView
        
    }
    
    func updateUI(){
        cityPickerView.tag = PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG
        districtPicketView.tag = PickerViewTagIndentifier.DISTRICT_PICKER_VIEW_TAG
        wardPickerView.tag = PickerViewTagIndentifier.WARD_PICKER_VIEW_TAG
        strictPickerView.tag = PickerViewTagIndentifier.STREET_PICKER_VIEW_TAG
        createPickerView()
    }
    
    @objc func btnDonePressed(){
        self.view.endEditing(true)
    }
}

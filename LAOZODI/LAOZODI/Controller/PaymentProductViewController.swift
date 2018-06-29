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
    let DistrictsData = [1:["Ba Đình","Hoàn Kiếm","Tây Hồ","Long Biên","Cầu Giấy","Đống Đa","Hai Bà Trưng","Hoàng Mai","Thanh Xuân","Hà Đông","Sơn Tây","Sóc Sơn","Đông Anh","Gia Lâm","Từ Liêm","Thanh Trì","Mê Linh","Ba Vì","Phúc Thọ","Đan Phượng","Hoài Đức","Quốc Oai","Thạch Thất","Chương Mỹ","Thanh Oai","Thường Tín","Phú Xuyên","Ứng Hòa","Mỹ Đức"],
                        2:["Hà Giang","Đồng Văn","Mèo Vạc","Yên Minh","Quản Bạ","Vị Xuyên","Bắc Mê","Hoàng Su Phì","Xín Mần","Bắc Quang","Quang Bình"],
                        4:["Cao Bằng","Bảo Lâm","Bảo Lạc","Thông Nông","Hà Quảng","Trà Lĩnh","Trùng Khánh","Hạ Lang","Quảng Uyên","Phục Hoà","Hoà An","Nguyên Bình","Thạch An"],
                        6:["Bắc Kạn","Pác Nặm","Ba Bể","Ngân Sơn","Bạch Thông","Chợ Đồn","Chợ Mới","Na Rì"],
                        8:["Tuyên Quang","Nà Hang","Chiêm Hóa","Hàm Yên","Yên Sơn","Sơn Dương"],
                        10:["Lào Cai","Bát Xát","Mường Khương","Si Ma Cai","Bắc Hà","Bảo Thắng","Bảo Yên","Sa Pa","Văn Bàn"],
                        11:["Điện Biên Phủ","Mường Lay","Mường Nhé","Mường Chà","Tủa Chùa","Tuần Giáo","Điện Biên","Điện Biên Đông","Mường Ảng"],
                        12:["Lai Châu","Tam Đường","Mường Tè","Sìn Hồ","Phong Thổ","Than Uyên","Tân Uyên"],
                        14:["Sơn La","Quỳnh Nhai","Thuận Châu","Mường La","Bắc Yên","Phù Yên","Mộc Châu","Yên Châu","Mai Sơn","Sông Mã","Sốp Cộp"],
                        15:["Yên Bái","Nghĩa Lộ","Lục Yên","Văn Yên","Mù Cang Chải","Trấn Yên","Trạm Tấu","Văn Chấn","Yên Bình"],
                        17:["Hòa Bình","Đà Bắc","Kỳ Sơn","Lương Sơn","Kim Bôi","Cao Phong","Tân Lạc","Mai Châu","Lạc Sơn","Yên Thủy","Lạc Thủy"],
                        19:["Thái Nguyên","Sông Công","Định Hóa","Phú Lương","Đồng Hỷ","Võ Nhai","Đại Từ","Phổ Yên","Phú Bình"],
                        20:["Lạng Sơn","Tràng Định","Bình Gia","Văn Lãng","Cao Lộc","Văn Quan","Bắc Sơn","Hữu Lũng","Chi Lăng","Lộc Bình","Đình Lập"],
                        22:["Hạ Long","Móng Cái","Cẩm Phả","Uông Bí","Bình Liêu","Tiên Yên","Đầm Hà","Hải Hà","Ba Chẽ","Vân Đồn","Hoành Bồ","Đông Triều","Yên Hưng","Cô Tô"],
                        24:["Bắc Giang","Yên Thế","Tân Yên","Lạng Giang","Lục Nam","Lục Ngạn","Sơn Động","Yên Dũng","Việt Yên","Hiệp Hòa"],
                        25:["Việt Trì","Phú Thọ","Đoan Hùng","Hạ Hoà","Thanh Ba","Phù Ninh","Yên Lập","Cẩm Khê","Tam Nông","Lâm Thao","Thanh Sơn","Thanh Thuỷ","Tân Sơn"],
                        26:["Vĩnh Yên","Phúc Yên","Lập Thạch","Tam Dương","Tam Đảo","Bình Xuyên","Yên Lạc","Vĩnh Tường","Sông Lô"],
                        27:["Bắc Ninh","Từ Sơn","Yên Phong","Quế Võ","Tiên Du","Thuận Thành","Gia Bình","Lương Tài"],
                        30:["Hải Dương","Chí Linh","Nam Sách","Kinh Môn","Kim Thành","Thanh Hà","Cẩm Giàng","Bình Giang","Gia Lộc","Tứ Kỳ","Ninh Giang","Thanh Miện"],
                        31:["Hồng Bàng","Ngô Quyền","Lê Chân","Hải An","Kiến An","Đồ Sơn","Kinh Dương","Thuỷ Nguyên","An Dương","An Lão","Kiến Thụy","Tiên Lãng","Vĩnh Bảo","Cát Hải","Bạch Long Vĩ"],
                        33:["Hưng Yên","Văn Lâm","Văn Giang","Yên Mỹ","Mỹ Hào","Ân Thi","Khoái Châu","Kim Động","Tiên Lữ","Phù Cừ"],
                        34:["Thái Bình","Quỳnh Phụ","Hưng Hà","Đông Hưng","Thái Thụy","Tiền Hải","Kiến Xương","Vũ Thư"],
                        35:["Phủ Lý","Duy Tiên","Kim Bảng","Thanh Liêm","Bình Lục","Lý Nhân"],
                        36:["Nam Định","Mỹ Lộc","Vụ Bản","Ý Yên","Nghĩa Hưng","Nam Trực","Trực Ninh","Xuân Trường","Giao Thủy","Hải Hậu"],
                        37:["Ninh Bình","Tam Điệp","Nho Quan","Gia Viễn","Hoa Lư","Yên Khánh","Kim Sơn","Yên Mô"],
                        38:["Thanh Hóa","Bỉm Sơn","Sầm Sơn","Mường Lát","Quan Hóa","Bá Thước","Quan Sơn","Lang Chánh","Ngọc Lặc","Cẩm Thủy","Thạch Thành","Hà Trung","Vĩnh Lộc","Yên Định","Thọ Xuân","Thường Xuân","Triệu Sơn","Thiệu Hoá","Hoằng Hóa","Hậu Lộc","Nga Sơn","Như Xuân","Như Thanh","Nông Cống","Đông Sơn","Quảng Xương","Tĩnh Gia"],
                        40:["Vinh","Cửa Lò","Thái Hoà","Quế Phong","Quỳ Châu","Kỳ Sơn","Tương Dương","Nghĩa Đàn","Quỳ Hợp","Quỳnh Lưu","Con Cuông","Tân Kỳ","Anh Sơn","Diễn Châu","Yên Thành","Đô Lương","Thanh Chương","Nghi Lộc","Nam Đàn","Hưng Nguyên"],
                        42:["Hà Tĩnh","Hồng Lĩnh","Hương Sơn","Đức Thọ","Vũ Quang","Nghi Xuân","Can Lộc","Hương Khê","Thạch Hà","Cẩm Xuyên","Kỳ Anh","Lộc Hà"],
                        44:["Đồng Hới","Minh Hóa","Tuyên Hóa","Quảng Trạch","Bố Trạch","Quảng Ninh","Lệ Thủy"],
                        45:["Đông Hà","Quảng Trị","Vĩnh Linh","Hướng Hóa","Gio Linh","Đa Krông","Cam Lộ","Triệu Phong","Hải Lăng","Cồn Cỏ"],
                        46:["Huế","Phong Điền","Quảng Điền","Phú Vang","Hương Thủy","Hương Trà","A Lưới","Phú Lộc","Nam Đông"],
                        48:["Liên Chiểu","Thanh Khê","Hải Châu","Sơn Trà","Ngũ Hành Sơn","Cẩm Lệ","Hoà Vang","Hoàng Sa"],
                        49:["Tam Kỳ","Hội An","Tây Giang","Đông Giang","Đại Lộc","Điện Bàn","Duy Xuyên","Quế Sơn","Nam Giang","Phước Sơn","Hiệp Đức","Thăng Bình","Tiên Phước","Bắc Trà My","Nam Trà My","Núi Thành","Phú Ninh","Nông Sơn"],
                        51:["Quảng Ngãi","Bình Sơn","Trà Bồng","Tây Trà","Sơn Tịnh","Tư Nghĩa","Sơn Hà","Sơn Tây","Minh Long","Nghĩa Hành","Mộ Đức","Đức Phổ","Ba Tơ","    Lý Sơn"],
                        52:["Qui Nhơn","An Lão","Hoài Nhơn","Hoài Ân","Phù Mỹ","Vĩnh Thạnh","Tây Sơn","Phù Cát","An Nhơn","Tuy Phước","Vân Canh"],
                        54:["Tuy Hòa    ","Sông Cầu","Đồng Xuân","Tuy An","Sơn Hòa","Sông Hinh","Tây Hoà","Phú Hoà","Đông Hoà"],
                        56:["Nha Trang","Cam Ranh","Cam Lâm","Vạn Ninh","Ninh Hòa","Khánh Vĩnh","Diên Khánh","Khánh Sơn","Trường Sa"],
                        58:["Phan Rang-Tháp Chàm","Bác Ái","Ninh Sơn","Ninh Hải","Ninh Phước","Thuận Bắc","Thuận Nam"],
                        60:["Phan Thiết","La Gi","Tuy Phong","Bắc Bình","Hàm Thuận Bắc","Hàm Thuận Nam","Tánh Linh","Đức Linh","Hàm Tân","Phú Quí"],
                        62:["Kon Tum","Đắk Glei","Ngọc Hồi","Đắk Tô","Kon Plông","Kon Rẫy","Đắk Hà","Sa Thầy","Tu Mơ Rông"],
                        64:["Pleiku","An Khê","Ayun Pa","Kbang","Đăk Đoa","Chư Păh","Ia Grai","Mang Yang","Kông Chro","Đức Cơ","Chư Prông","Chư Sê","Đăk Pơ","Ia Pa","Krông Pa","Phú Thiện","Chư Pưh"],
                        66:["Buôn Ma Thuột","Buôn Hồ","Ea H'leo","Ea Súp","Buôn Đôn","Cư M'gar","Krông Búk","Krông Năng","Ea Kar","M'đrắk","Krông Bông","Krông Pắc","Krông A Na","Lắk","Cư Kuin"],
                        67:["Gia Nghĩa","Đắk Glong","Cư Jút","Đắk Mil","Krông Nô","Đắk Song","Đắk R'lấp","Tuy Đức"],
                        68:["Đà Lạt","Bảo Lộc","Đam Rông","Lạc Dương","Lâm Hà","Đơn Dương","Đức Trọng","Di Linh","Bảo Lâm","Đạ Huoai","Đạ Tẻh","Cát Tiên"],
                        70:["Đồng Xoài","Phước Long","Bình Long","Bù Gia Mập","Lộc Ninh","Bù Đốp","Hớn Quản","Đồng Phù","Bù Đăng","Chơn Thành"],
                        72:["Tây Ninh","Tân Biên","Tân Châu","Dương Minh Châu","Châu Thành","Hòa Thành","Gò Dầu","Bến Cầu","Trảng Bàng"],
                        74:["Thủ Dầu Một","Dầu Tiếng","Bến Cát","Phú Giáo","Tân Uyên","Dĩ An","Thuận An"],
                        75:["Biên Hòa","Long Khánh","Tân Phú","Vĩnh Cửu","Định Quán","Trảng Bom","Thống Nhất","Cẩm Mỹ","Long Thành","Xuân Lộc","Nhơn Trạch"],
                        77:["Vũng Tầu","Bà Rịa","Châu Đức","Xuyên Mộc","Long Điền","Đất Đỏ","Tân Thành","Côn Đảo"],
                        79:["1","12","Thủ Đức","9","Gò Vấp","Bình Thạnh","Tân Bình","Tân Phú","Phú Nhuận","2","3","10","11","4","5","6","8","Bình Tân","7","Củ Chi","Hóc Môn","Bình Chánh","Nhà Bè","Cần Giờ"],
                        80:["Tân An","Tân Hưng","Vĩnh Hưng","Mộc Hóa","Tân Thạnh","Thạnh Hóa","Đức Huệ","Đức Hòa","Bến Lức","Thủ Thừa","Tân Trụ","Cần Đước","Cần Giuộc","Châu Thành"],
                        82:["Mỹ Tho","Gò Công","Tân Phước","Cái Bè","Cai Lậy","Châu Thành","Chợ Gạo","Gò Công Tây","Gò Công Đông","Tân Phú Đông"],
                        83:["Bến Tre    ","Châu Thành","Chợ Lách","Mỏ Cày Nam","Giồng Trôm","Bình Đại","Ba Tri","Thạnh Phú","Mỏ Cày Bắc"],
                        84:["Trà Vinh","Càng Long","Cầu Kè","Tiểu Cần","Châu Thành","Cầu Ngang","Trà Cú","Duyên Hải"],
                        86:["Vĩnh Long","Long Hồ","Mang Thít","Vũng Liêm","Tam Bình","Bình Minh","Trà Ôn","Bình Tân"],
                        87:["Cao Lãnh","Sa Đéc","Hồng Ngự","Tân Hồng","Hồng Ngự","Tam Nông","Tháp Mười","Cao Lãnh","Thanh Bình","Lấp Vò","Lai Vung","Châu Thành"],
                        89:["Long Xuyên","Châu Đốc","An Phú","Tân Châu","Phú Tân","Châu Phú","Tịnh Biên","Tri Tôn","Châu Thành","Chợ Mới","Thoại Sơn"],
                        91:["Rạch Giá","Hà Tiên","Kiên Lương","Hòn Đất","Tân Hiệp","Châu Thành","Giồng Giềng","Gò Quao","An Biên","An Minh","Vĩnh Thuận","Phú Quốc","Kiên Hải","U Minh Thượng","Giang Thành"],
                        92:["Ninh Kiều","Ô Môn","Bình Thuỷ","Cái Răng","Thốt Nốt","Vĩnh Thạnh","Cờ Đỏ","Phong Điền","Thới Lai"],
                        93:["Vị Thanh","Ngã Bảy","Châu Thành A","Châu Thành","Phụng Hiệp","Vị Thuỷ","Long Mỹ"],94:["Sóc Trăng","Châu Thành","Kế Sách","Mỹ Tú","Cù Lao Dung","Long Phú","Mỹ Xuyên","Ngã Năm","Thạnh Trị","Vĩnh Châu","Trần Đề"],
                        95:["Bạc Liêu","Hồng Dân","Phước Long","Vĩnh Lợi","Giá Rai","Đông Hải","Hoà Bình"],
                        96:["Cà Mau","U Minh","Thới Bình","Trần Văn Thời","Cái Nước","Đầm Dơi","Năm Căn","Phú Tân","Ngọc Hiển"]]
    let CityID = ["Hà Nội":1,
                  "Hà Giang":2,
                  "Cao Bằng":4,
                  "Bắc Kạn":6,
                  "Tuyên Quang":8,
                  "Lào Cai":10,
                  "Điện Biên":11,
                  "Lai Châu":12,
                  "Sơn La":14,
                  "Yên Bái":15,
                  "Hòa Bình":17,
                  "Thái Nguyên":19,
                  "Lạng Sơn":20,
                  "Quảng Ninh":22,
                  "Bắc Giang":24,
                  "Phú Thọ":25,
                  "Vĩnh Phúc":26,
                  "Bắc Ninh":27,
                  "Hải Dương":30,
                  "Hải Phòng":31,
                  "Hưng Yên":33,
                  "Thái Bình":34,
                  "Hà Nam":35,
                  "Nam Định":36,
                  "Ninh Bình":37,
                  "Thanh Hóa":38,
                  "Nghệ An":40,
                  "Hà Tĩnh":42,
                  "Quảng Bình":44,
                  "Quảng Trị":45,
                  "Thừa Thiên Huế":46,
                  "Đà Nẵng":48,
                  "Quảng Nam":49,
                  "Quảng Ngãi":51,
                  "Bình Định":52,
                  "Phú Yên":54,
                  "Khánh Hòa":56,
                  "Ninh Thuận":58,
                  "Bình Thuận":60,
                  "Kon Tum":62,
                  "Gia Lai":64,
                  "Đắk Lắk":66,
                  "Đắk Nông":67,
                  "Lâm Đồng":68,
                  "Bình Phước":70,
                  "Tây Ninh":72,
                  "Bình Dương":74,
                  "Đồng Nai":75,
                  "Bà Rịa - Vũng Tàu":77,
                  "Hồ Chí Minh":79,
                  "Long An":80,
                  "Tiền Giang":82,
                  "Bến Tre":83,
                  "Trà Vinh":84,
                  "Vĩnh Long":86,
                  "Đồng Tháp":87,
                  "An Giang":89,
                  "Kiên Giang":91,
                  "Cần Thơ":92,
                  "Hậu Giang":93,
                  "Sóc Trăng":94,
                  "Bạc Liêu":95,
                  "Cà Mau":96]

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
        case PickerViewTagIndentifier.DISTRICT_PICKER_VIEW_TAG:
            
            var id:Int = CityID[tfCity.text!] as!Int
            var DistrictArr:[String] = DistrictsData[id] as! [String];
            return DistrictArr.count
        default:
            return -1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG:
            return citiesData[row]
        case PickerViewTagIndentifier.DISTRICT_PICKER_VIEW_TAG:
            
            var id:Int = CityID[tfCity.text!] as!Int
            var DistrictArr:[String] = DistrictsData[id] as! [String];
            return DistrictArr[row]
        default:
            return ""
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case PickerViewTagIndentifier.CITY_PICKER_VIEW_TAG:
            tfCity.text = citiesData[row]
        case PickerViewTagIndentifier.DISTRICT_PICKER_VIEW_TAG:
            
            var id:Int = CityID[tfCity.text!] as!Int
            var DistrictArr:[String] = DistrictsData[id] as! [String];
            tfDistrict.text = DistrictArr[row]
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

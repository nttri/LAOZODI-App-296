//
//  AccountOptionTableVC.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/30/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class AccountOptionTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1){
            let alertController = UIAlertController(title: "TRỢ GIÚP", message: """
            LAOZODI sinh ra để thoả mãn nhu cầu giao dịch của của người tiêu dùng Việt Nam

            Một sản phẩm của
            NGUYỄN THANH TRÍ - 1512605
            MAI HỮU TUẤN - 1512635
            PHẠM ANH TUẤN - 1512639
            """, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: nil))
            self.present(alertController, animated: true,completion: nil)
        }
        if(indexPath.row == 0){
            //self.performSegue(withIdentifier: "showEditInfoSegue", sender: nil)
            //AccountViewController().performSegue(withIdentifier: "showEditInfoSegue", sender: nil)
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "editAccountInfoSegue"){
//            if let vc = segue.destination as? AccountInfoEditTVC{
//                print("@@@@")
//            }
//        }
//    }

}

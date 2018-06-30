//
//  AccountViewController.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/30/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTouched(_ sender: Any) {
        FirebaseAuthenAPI.sharedInstance.logout()
    }
    
    func showEditInfoVC(){
        self.performSegue(withIdentifier: "showEditInfoSegue", sender: self)
    }
    
}

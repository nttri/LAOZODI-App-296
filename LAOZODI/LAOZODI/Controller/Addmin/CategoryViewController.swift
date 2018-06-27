//
//  CatagoryViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/28/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class CatagoryViewController: UIViewController {

    @IBOutlet weak var text: UILabel!
    var type: String = AppCons.Category.THOI_TRANG_NAM
    @IBOutlet weak var btnCategoryMenu: UIBarButtonItem!
    var slideCategoryMenu:SlideCategoryViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCategoryMenu.target = self.revealViewController()
        btnCategoryMenu.action = Selector("revealToggle:")
        self.revealViewController().rearViewRevealWidth = 250
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
        //slideCategoryMenu?.categoryDelegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SlideCategoryViewController"{
            let naVC = segue.destination as! SlideCategoryViewController;
            naVC.categoryDelegate = self
            // DELEGATE - Step 5
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CatagoryViewController: CategoryDelegate{
    func sendData() {
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    }
    
    
}

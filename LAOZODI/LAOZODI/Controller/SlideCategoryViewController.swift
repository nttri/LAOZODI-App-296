//
//  SlideCategoryViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/28/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

protocol CategoryDelegate :class{
    func sendData()
}
class SlideCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let categorys = [AppCons.Category.DO_AN_HANG_HOA,
                     AppCons.Category.DO_CHOI_ME_BE,
                     AppCons.Category.OTO_XEMAY,
                     AppCons.Category.PHU_KIEN_DIEN_TU,
                     AppCons.Category.PHU_KIEN_THOI_TRANG,
                     AppCons.Category.SUC_KHOE_LAM_DEP,
                     AppCons.Category.THE_THAO_DU_LICH,
                     AppCons.Category.THIET_BI_DIEN_TU,
                     AppCons.Category.THOI_TRANG_NAM,
                     AppCons.Category.THOI_TRANG_NU]
    weak var categoryDelegate : CategoryDelegate?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  categorys.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoryDelegate?.sendData()
        let desController = storyboard?.instantiateViewController(withIdentifier: "CatagoryViewController") as!CatagoryViewController
        desController.type = categorys[indexPath.row]
        let newFronViewController = UINavigationController.init(rootViewController :desController)
        revealViewController().pushFrontViewController(newFronViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
        //cell?.textLabel?.text = categorys[indexPath.row]
        cell.name.text = categorys[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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

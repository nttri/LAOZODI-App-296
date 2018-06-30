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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}

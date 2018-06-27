//
//  SearchTableViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/26/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import  FirebaseDatabase

class SearchTableViewController: UITableViewController {

    var datas :[String] = []
    var handleSearchProductDelegate:HandleSearchProductDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSearchProductDelegate?.setTextForSearchBar(WorldSearch: datas[indexPath.row])
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchTableViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchTableViewCell
        cell.productName.text = datas[indexPath.row]
        return cell
        
    }
}
extension SearchTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        self.datas = []
        guard let searchBarText = searchController.searchBar.text else {return}
        FirebaseManager.shared.databaseReference.observe(.childAdded, with: { (dataSnapshot) in
            //print("SNAP SHOT\(dataSnapshot)")
            
            //self.listMainProduct = []
            let menClothing = dataSnapshot.childSnapshot(forPath: AppCons.ManFashionGroupProduct.MEN_CLOTHING)
            
            let menClothing_coat = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.COAT)
            let menClothing_jeans = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.JEANS)
            let menClothing_poloShirt = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.POLO_SHIRT)
            let menClothing_shirt = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.SHIRT)
            let menClothing_shorts = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.SHORTS)
            let menClothing_tShirt = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.T_SHIRT)
            let menClothing_vest = menClothing.childSnapshot(forPath: AppCons.ManClothingGroupProduct.VEST)
            
            if menClothing_coat != nil{
                // print("COAT \(menClothing_coat)")
                let listCoat = self.getListProductsNameOfADataSnapshotProductType(DataSnapshotProductType: menClothing_coat,WorldSearch: searchBarText)
                self.datas += listCoat
              //  print("COATS : \(self.listMainProduct.count)")
            }
            
            if menClothing_jeans != nil{
                let listCoat = self.getListProductsNameOfADataSnapshotProductType(DataSnapshotProductType: menClothing_jeans,WorldSearch: searchBarText)
                self.datas += listCoat
            }
            
            if menClothing_shirt != nil{
                let listCoat = self.getListProductsNameOfADataSnapshotProductType(DataSnapshotProductType: menClothing_shirt,WorldSearch: searchBarText)
                self.datas += listCoat
            }
            
            if menClothing_poloShirt != nil{
                
            }
            
            if menClothing_shirt != nil{
                
            }
            
            if menClothing_shorts != nil{
                
            }
            
            if menClothing_tShirt != nil{
                
            }
            
            if menClothing_vest != nil{
                
            }
            
            
            self.tableView.reloadData()
            //self.collectionView.reloadData()
        })
        
        // Do any additional setup after loading the view.
        
    }
    func getListProductsNameOfADataSnapshotProductType( DataSnapshotProductType dataSnapshotProductType : DataSnapshot,WorldSearch word:String) ->[String]{
        var products:[String] = []
        for child in dataSnapshotProductType.children{
            
            let _child: DataSnapshot  = child as! DataSnapshot
            
            let productName: String  = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.NAME).value as? String)!
            
            let productNamelower  = productName.lowercased()
            if(productNamelower.contains(word.lowercased())){
                products.append(productName)
            }
        }
        return products
    }
    
}

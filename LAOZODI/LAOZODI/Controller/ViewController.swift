//
//  ViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/28/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import FirebaseDatabase


protocol HandleSearchProductDelegate: class {
    func setTextForSearchBar(WorldSearch word:String)
}
class ViewController: UIViewController,UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var listMainProduct:[Product] = []
    var mySearchTableViewController: SearchTableViewController?
    //var handlerSendSelectedProductDelegate:HandlerSendSelectedProductDelegate? = nil
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    var searchController : UISearchController!
    var productData:ProductType = ProductType()
    var databaseHandle :DatabaseHandle?

    override func viewDidLoad() {
        //DataSetting.readDataFormImportFile()
        super.viewDidLoad()
       // DataSetting.readDataFormImportFile()
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        mySearchTableViewController = storyboard!.instantiateViewController(withIdentifier: AppCons.Identify.SEARCH_PRODUCT_TABLE_INDENTIFY!) as! SearchTableViewController
        self.searchController = UISearchController(searchResultsController: mySearchTableViewController)
        
        
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = mySearchTableViewController
        
        self.searchController.hidesNavigationBarDuringPresentation  =  false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.titleView = self.searchController.searchBar
        self.definesPresentationContext = true
        
        collectionView.delegate
            = self
        collectionView.dataSource = self
        mySearchTableViewController?.handleSearchProductDelegate = self
        
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
                let listCoat = self.getListProductsOfADataSnapshotProductType(DataSnapshotProductType: menClothing_coat)
                self.listMainProduct += listCoat
                print("COATS : \(self.listMainProduct.count)")
            }
            
            if menClothing_jeans != nil{
                let listCoat = self.getListProductsOfADataSnapshotProductType(DataSnapshotProductType: menClothing_jeans)
                self.listMainProduct += listCoat
            }
            
            if menClothing_shirt != nil{
                let listCoat = self.getListProductsOfADataSnapshotProductType(DataSnapshotProductType: menClothing_shirt)
                self.listMainProduct += listCoat
            }
            
           
            self.collectionView.reloadData()
            //self.collectionView.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }
    
    func getListProductsOfADataSnapshotProductType( DataSnapshotProductType dataSnapshotProductType : DataSnapshot) ->[Product]{
        var products:[Product] = []
        for child in dataSnapshotProductType.children{
            
            let _child: DataSnapshot  = child as! DataSnapshot
            
            let productName: String  = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.NAME).value as? String)!
            let productBrand: String = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.BRAND).value as? String)!
            let productDescription: String = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.DESCRIPTION).value as? String)!
            let productId: Int = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as? Int)!
            let productPrice: Int = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.PRICE).value as? Int)!
            let productWarranty: Int = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.WARRANTY).value as? Int)!
            let productStrURLImage: String = (_child.childSnapshot(forPath: AppCons.ProductTableAttribute.STR_URL_IMAGE).value as? String)!
            
            let product = Product(Identifier: productId, Name: productName, Description: productDescription, Price: productPrice, Brand: productBrand, StrURLImage: productStrURLImage, Warranty: productWarranty)
            products.append(product)
        }
        return products
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

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMainProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCell
       
        cell.clipsToBounds = false
        cell.layer.cornerRadius = 14
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        var productCell: ProductCell!{
            didSet{
                
            }
        }
        cell.productName.text = self.listMainProduct[indexPath.row].name
        cell.productPrice.text = "\(self.listMainProduct[indexPath.row].price)  VND"
        //cell.productImage.getImageFromUrl(url: self.listMainProduct[indexPath.row].strURLImage)
        
       // print("URL :\(self.listMainProduct[indexPath.row].strURLImage)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = listMainProduct[indexPath.row]
       // handlerSendSelectedProductDelegate?.setProDuct(ProductSending: product)
        let productDetailViewController: ProductDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: AppCons.Identify.PRODUCT_DEATAIL_VIEW_CONTROLLER_IDENTIFY!) as! ProductDetailViewController
        productDetailViewController.product = listMainProduct[indexPath.row]
        
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/2 - 8
        let height = self.view.frame.height/3
        
        return CGSize(width: width, height: height)
    }

    
    
}

extension ViewController: HandleSearchProductDelegate{
    func setTextForSearchBar(WorldSearch word: String) {
        self.searchController.searchBar.text = word
    }
}

extension UIImageView{
    public func getImageFromUrl(url: String){
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: {(data,response,error)->Void in
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {() -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}

//
//  CatagoryViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/28/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CatagoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var datas :[String] = [];
    var listProducts:[Product] = []
    
    @IBOutlet var collectionView: UICollectionView!
    var type: String = AppCons.Category.THOI_TRANG_NAM
    @IBOutlet weak var btnCategoryMenu: UIBarButtonItem!
    var slideCategoryMenu:SlideCategoryViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        btnCategoryMenu.target = self.revealViewController()
        btnCategoryMenu.action = Selector("revealToggle:")
        self.revealViewController().rearViewRevealWidth = 250
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        loadCategoryDataByCategoryType()
        
   
        //slideCategoryMenu?.categoryDelegate = self
        // Do any additional setup after loading the view.
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as!ProductCollectionViewCell
        
        let currentProduct = listProducts[indexPath.row]
        collectionViewCell.name.text = currentProduct.name
        collectionViewCell.price.text = "\(currentProduct.price/1000)k"
        collectionViewCell.brand.text = currentProduct.brand
        collectionViewCell.iamge.image = UIImage(named: "templateCoat")
        let productImageURL = currentProduct.strURLImage
        
        if productImageURL != nil{
                let url = URL(string: productImageURL)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data,resspond,error) in
                    if error != nil{
                        print("@@@@@@@@@@@@@@ ERROR\(error) @@@@@@@@@@@@")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        
                        collectionViewCell.iamge.image = UIImage(data: data!)
                    }

                }).resume()
            }
        
        collectionViewCell.makeShadowAnimation()
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/3 - 8
        let height = self.view.frame.height/3  - 16
        
        return CGSize(width: width, height: height)
    }
    

}

extension CatagoryViewController{
    func loadCategoryDataByCategoryType(){
        switch self.type{
        case AppCons.Category.THIET_BI_DIEN_TU:
            createListElectronicProductData(ElectronicGroup: AppCons.ElectronicDeviceGroupProduct.MOBILE_PHONE)
            break
        case  AppCons.Category.DO_AN_HANG_HOA:
            createListFoods(ElectronicGroup: "Food")
            break
            
        case AppCons.Category.DO_CHOI_ME_BE:
            createListData(Root: AppCons.ProductGroupName.BABY_TOY_MOTHER, Node: AppCons.CommonAttribute.BABYTOY_MOTHER_SUB_GROUP, Leaf: AppCons.CommonAttribute.PRODUCT)
            break
        default:
            break
        }
    }
    
    func createListElectronicProductData(ElectronicGroup electronicGroup: String){
        FirebaseManager.shared.databaseReference.child(AppCons.ProductGroupName.ELECTRONIC_DEVICE).child(electronicGroup).observeSingleEvent(of: .value) { (dataSnapshot) in
            let productsDataSnapshot = dataSnapshot.childSnapshot(forPath: "Product")
        
            var products:[Product] = []
            for child in productsDataSnapshot.children{
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
            self.listProducts = products
            self.collectionView.reloadData()
        }
    }
    
    
    func createListFoods(ElectronicGroup foodGroup: String){
        FirebaseManager.shared.databaseReference.child(AppCons.ProductGroupName.FOODS).child(foodGroup).observeSingleEvent(of: .value) { (dataSnapshot) in
            let productsDataSnapshot = dataSnapshot.childSnapshot(forPath: "Product")
            
            var products:[Product] = []
            for child in productsDataSnapshot.children{
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
            self.listProducts = products
            self.collectionView.reloadData()
        }
    }
    
    func createListData(Root root:String, Node node: String, Leaf leaf:String){
        FirebaseManager.shared.databaseReference.child(root).child(node).observeSingleEvent(of: .value) { (dataSnapshot) in
            let productsDataSnapshot = dataSnapshot.childSnapshot(forPath: leaf)
            
            var products:[Product] = []
            for child in productsDataSnapshot.children{
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
            self.listProducts = products
            self.collectionView.reloadData()
        }
    }
    
}

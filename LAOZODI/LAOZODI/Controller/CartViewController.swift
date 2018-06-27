//
//  CartViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/10/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CartViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var listProduct:[ProductInCartObject] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductInCartCollectionViewCell
        cell.lbProductName.text = listProduct[indexPath.row].product?.name
        cell.tfAmount.text = "\(listProduct[indexPath.row].number)"
        cell.tfProductPrice.text = "\(listProduct[indexPath.row].product!.price * listProduct[indexPath.row].number) VND"
        cell.imgProduct.layer.cornerRadius =  cell.imgProduct.frame.height/2
        return cell
    }
    
    
    
    
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
//        listProduct =  []
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        let height = (view.frame.height - 100)/4
        let with = view.frame.width
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    
        layout.itemSize = CGSize(width: with, height: height)
        btnPayment.setGradientBackground(colorOne: UIColor(red: 0.21, green: 0.82, blue: 0.86, alpha: 1), colorTwo: UIColor(red: 0.36, green: 0.53, blue: 0.9, alpha: 1))
        
                FirebaseManager.shared.databaseReference.observe(.value
                    , with: {(dataSnapshot) in
                        self.listProduct.removeAll()
                        let listProductInCart = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
                    print("############ .value child \(listProductInCart)")
                   
                        
                    for child in listProductInCart.children{
                       
                        print("############child \(child)")
                        let _child = child as! DataSnapshot
                        let productSnapShot = (_child.childSnapshot(forPath: AppCons.CartTableAtrribute.PRODUCT)) as! DataSnapshot
        
                        let productName: String  = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.NAME).value as? String)!
                        let productBrand: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.BRAND).value as? String)!
                        let productDescription: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.DESCRIPTION).value as? String)!
                        let productId: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as? Int)!
                        let productPrice: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.PRICE).value as? Int)!
                        let productWarranty: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.WARRANTY).value as? Int)!
                        let productStrURLImage: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.STR_URL_IMAGE).value as? String)!
        
                        let product = Product(Identifier: productId, Name: productName, Description: productDescription, Price: productPrice, Brand: productBrand, StrURLImage: productStrURLImage, Warranty: productWarranty)
        
                        let number = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.NUMBER_PRODUCT).value as! Int
        
                        self.listProduct.append(ProductInCartObject(Product: product, Amount: number))
        
                        print("###################length \(self.listProduct.count)")
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                })
        
                FirebaseManager.shared.databaseReference.observe(.childAdded
                    , with: {(dataSnapshot) in
        
                        let listProductInCart = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
                        print("############ .chidl added child \(listProductInCart)")
        
                        for child in listProductInCart.children{
                            print("############child \(child)")
                            let _child = child as! DataSnapshot
                            let productSnapShot = (_child.childSnapshot(forPath: AppCons.CartTableAtrribute.PRODUCT)) as! DataSnapshot
        
                            let productName: String  = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.NAME).value as? String)!
                            let productBrand: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.BRAND).value as? String)!
                            let productDescription: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.DESCRIPTION).value as? String)!
                            let productId: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as? Int)!
                            let productPrice: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.PRICE).value as? Int)!
                            let productWarranty: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.WARRANTY).value as? Int)!
                            let productStrURLImage: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.STR_URL_IMAGE).value as? String)!
        
                            let product = Product(Identifier: productId, Name: productName, Description: productDescription, Price: productPrice, Brand: productBrand, StrURLImage: productStrURLImage, Warranty: productWarranty)
        
                            let number = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.NUMBER_PRODUCT).value as! Int
        
                            self.listProduct.append(ProductInCartObject(Product: product, Amount: number))
        
                            print("###################length \(self.listProduct.count)")
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                })
        
        FirebaseManager.shared.databaseReference.observe(.childChanged
            , with: {(dataSnapshot) in

                let listProductInCart = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
                print("############child  .childChanged \(listProductInCart)")
                
                for child in listProductInCart.children{
                    print("############child \(child)")
                    let _child = child as! DataSnapshot
                    let productSnapShot = (_child.childSnapshot(forPath: AppCons.CartTableAtrribute.PRODUCT)) as! DataSnapshot
                    
                    let productName: String  = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.NAME).value as? String)!
                    let productBrand: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.BRAND).value as? String)!
                    let productDescription: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.DESCRIPTION).value as? String)!
                    let productId: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as? Int)!
                    let productPrice: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.PRICE).value as? Int)!
                    let productWarranty: Int = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.WARRANTY).value as? Int)!
                    let productStrURLImage: String = (productSnapShot.childSnapshot(forPath: AppCons.ProductTableAttribute.STR_URL_IMAGE).value as? String)!
                    
                    let product = Product(Identifier: productId, Name: productName, Description: productDescription, Price: productPrice, Brand: productBrand, StrURLImage: productStrURLImage, Warranty: productWarranty)
                    
                    let number = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.NUMBER_PRODUCT).value as! Int
                    
                    self.listProduct.append(ProductInCartObject(Product: product, Amount: number))
                    
                    print("###################length \(self.listProduct.count)")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
        })
        
        
        // Do any additional setup after loading the view.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func onBtnDeincreasingClick(_ sender: Any) {
        let hitPoint = (sender as! UIButton).convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: hitPoint){
            let row = (indexPath as! IndexPath).row
            print("########################   NAME : \(listProduct[row].product?.name) ####################")
            if(listProduct[row].number > 0){
                listProduct[row].number = listProduct[row].number  - 1
            }
            else{
                FirebaseManager.shared.databaseReference.observeSingleEvent(of: .value, with: { (dataSnapshot) in
                    let list = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
                    let key = FirebaseManager.shared.getKeyValueOfObject(ListProduct: list, Product: self.listProduct[row].product!)
                    self.listProduct.remove(at: row)
                    FirebaseManager.shared.databaseReference.child(AppCons.TableName.CART).child(key).removeValue()
                    print("######## KEY : \(key)")
                }, withCancel: nil)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    @IBAction func onBtnIncreasingClick(_ sender: Any) {
        let hitPoint = (sender as! UIButton).convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: hitPoint){
            let row = (indexPath as! IndexPath).row
            listProduct[row].number = listProduct[row].number + 1
            FirebaseManager.shared.databaseReference.observeSingleEvent(of: .value, with: { (dataSnapshot) in
                let list = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
                let key = FirebaseManager.shared.getKeyValueOfObject(ListProduct: list, Product: self.listProduct[row].product!)
              //  self.listProduct.remove(at: row)
                FirebaseManager.shared.databaseReference.child(AppCons.TableName.CART).child(key).updateChildValues([AppCons.CartTableAtrribute.NUMBER_PRODUCT : self.listProduct[row].number])
                print("######## KEY : \(key)")
            }, withCancel: nil)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
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

extension UIView{
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor){
        let gradientColor = CAGradientLayer()
        gradientColor.frame = bounds
        gradientColor.colors = [colorOne.cgColor,colorTwo.cgColor]
        gradientColor.locations = [0.0,1.0]
        gradientColor.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientColor.endPoint = CGPoint(x:0.0, y:0.0)
        layer.insertSublayer(gradientColor, at: 0)
    }
}

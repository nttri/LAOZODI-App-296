//
//  ProductDetailViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 6/9/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

//protocol HandlerSendSelectedProductDelegate {
//    func setProDuct(ProductSending product: Product)
//}
class ProductDetailViewController: UIViewController {
    var product: Product? = nil
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbProductPrice: UILabel!
    @IBOutlet weak var taProductDescription: UITextView!
    
    @IBOutlet weak var btnAddHeart: UIButton!
    var isFullHeart:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddToCart.setGradientBackground(colorOne: UIColor(red: 0.21, green: 0.82, blue: 0.86, alpha: 1), colorTwo: UIColor(red: 0.36, green: 0.53, blue: 0.9, alpha: 1))
        //viewController?.handlerSendSelectedProductDelegate = self
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.tintColor = UIColor.
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.lbProductName.text = product?.name
        self.lbProductPrice.text = "\(product!.price) VND"
        self.taProductDescription.text = product?.description
        
        let productImageURL = product?.strURLImage
        
        productImage.makeShadowAnimation()
        btnAddHeart.makeShadowAnimation()
        btnAddToCart.makeShadowAnimation()
        
        if productImageURL != nil{
            let url = URL(string: productImageURL!)
            URLSession.shared.dataTask(with: url!, completionHandler: {(data,resspond,error) in
                if error != nil{
                    print("@@@@@@@@@@@@@@ ERROR\(error) @@@@@@@@@@@@")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.productImage.image = UIImage(data: data!)
                }
                
            }).resume()
        }
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBtnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onBtnAddToCartClick(_ sender: Any) {
        
        FirebaseManager.shared.addProductToCart(Product: product!)
        let alertController = UIAlertController(title: "THôNG BÁO", message: "Bạn đã thêm sản phẩm \(product!.name) vào giỏ hàng", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Xem giỏ Hàng", style: .default, handler: {(UIAlertAction) in self.showCartViewController()}
            ))
        alertController.addAction(UIAlertAction(title: "Tiếp Tục mua hàng", style: .cancel, handler: {(UIAlertAction) in self.showListProduct()}))
        self.present(alertController, animated: true,completion: nil)
        
    }
    
    func showCartViewController(){
        self.tabBarController?.selectedIndex = 1
    }
    
    func showListProduct(){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBtnAddHeartClick(_ sender: Any) {
        if isFullHeart == true {
            self.btnAddHeart.setImage(UIImage(named: "hear"), for: .normal)
        }
        else{
            self.btnAddHeart.setImage(UIImage(named: "fullHeart"), for: .normal)
        }
        
        isFullHeart = !isFullHeart
        print("@@@@@@@@@@@@@@@@@@@@\(isFullHeart)")
    }
}



//extension ProductDetailViewController: HandlerSendSelectedProductDelegate{
//    func setProDuct(ProductSending product: Product) {
//        self.product = product;
//        lbProductName.text = product.name
//        print("###################################### :\(product.name)#")
//        if lbProductName.text == ""{
//            lbProductName.text = "can not sending data"
//        }
//    }
//
//
//}


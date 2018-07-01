//
//  FirebaseManager.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/27/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation
import FirebaseDatabase
public class FirebaseManager{
    
    static let shared: FirebaseManager = FirebaseManager()
    
    let databaseReference: DatabaseReference!
    init(){
        
        databaseReference = Database.database().reference()
    }

    func getListCoatsInMenClothingFashionProduct() ->[Product]{
        return [];
    }
    
    func addProductToFirebaseDatabase(Product product: Product,ProductGroup productGroup:String, SubGroup subGroup:String, ProductType productType:String){
        let productJSonObject = toJson(object: product, objectType: .PRODUCT_OBJECT)
        databaseReference.child(productGroup).child(subGroup).child(productType).childByAutoId().setValue(productJSonObject)

    }
    
    func toJson(object: Any,objectType : AppCons.ObjectType) ->[String:Any]{
        switch objectType {
        case .PRODUCT_OBJECT:
            let product = object as! Product
            let productJSonObject = [AppCons.ProductTableAttribute.ID: product.identifier,
                                     AppCons.ProductTableAttribute.NAME : product.name,
                                     AppCons.ProductTableAttribute.PRICE: product.price,
                                     AppCons.ProductTableAttribute.BRAND : product.brand,
                                     AppCons.ProductTableAttribute.DESCRIPTION : product.description,
                                     AppCons.ProductTableAttribute.WARRANTY : product.warranty,
                                     AppCons.ProductTableAttribute.STR_URL_IMAGE: product.strURLImage] as [String : Any]
            return productJSonObject
        case .ORDER_OBJECT:
            let orderObject = object as! OrderObject
            let orderJsonObject = [AppCons.OrderObject.ORDER_NUMBER: orderObject.orderNumber,
            AppCons.OrderObject.ORDER_INFO: orderObject.orderInfo] as [String: Any]
            return orderJsonObject
        case .USER_OBJECT:
            let user = object as! User
            let userjson = [AppCons.User.USER_EMAIL: user.email,
                            AppCons.User.USER_NAME: user.name,
                            AppCons.User.USER_BIRTHDAY: user.birthday,
                            AppCons.User.USER_GENDER: user.gender,
                            AppCons.User.USER_PASSWORD: user.password] as [String:Any]
            return userjson
        default:
            break
        }
        return [:]
    
    }
    
    /***********************************************************************************
     * function for :
     * add a product to cart in firebase
     **********************************************************************************/
    func addProductToCart(Product product: Product){
        let productJsonObject = toJson(object: product, objectType: .PRODUCT_OBJECT)
        databaseReference.observeSingleEvent(of: .value, with: {(dataSnapshot) in
            let listProductInCart = dataSnapshot.childSnapshot(forPath: AppCons.TableName.CART)
            if listProductInCart.childrenCount != 0{
                print("####################CALLING FUNCTION  : \(listProductInCart)###############################")
                var amount : Int = self.checkIsExistProductInCart(ListProductInCart: listProductInCart, Product: product)
               
                if amount != -1 {
                    let key = self.getKeyValueOfObject(ListProduct: listProductInCart, Product: product)
                    print("###################KEY : \(key) #########################")
                    let cartProductJsonObject = [
                        AppCons.CartTableAtrribute.PRODUCT :  productJsonObject,
                        AppCons.CartTableAtrribute.NUMBER_PRODUCT : amount + 1
                        ] as [String : Any]
                    
                    self.databaseReference.child(AppCons.TableName.CART).child(key).updateChildValues([AppCons.CartTableAtrribute.NUMBER_PRODUCT : amount + 1])
                }
                else{
                    let cartProductJsonObject = [
                        AppCons.CartTableAtrribute.PRODUCT :  productJsonObject,
                        AppCons.CartTableAtrribute.NUMBER_PRODUCT : 1
                        ] as [String : Any]
                self.databaseReference.child(AppCons.TableName.CART).childByAutoId().setValue(cartProductJsonObject)
                }
            
            }
            else{
                print("##################---NOT NILL---###############################")
                let cartProductJsonObject = [
                    AppCons.CartTableAtrribute.PRODUCT :  productJsonObject,
                    AppCons.CartTableAtrribute.NUMBER_PRODUCT : 1
                    ] as [String : Any]
                self.databaseReference.child(AppCons.TableName.CART).childByAutoId().setValue(cartProductJsonObject)
            }
        })
    }

    
    func addOrderObject(OrderObject orderObject: OrderObject){
        let orderJsonObject = toJson(object: orderObject, objectType: .ORDER_OBJECT)
        self.databaseReference.child(AppCons.OrderGroup.ORDER).childByAutoId().setValue(orderJsonObject)
        self.databaseReference.child(AppCons.OrderGroup.ORDER).child(AppCons.OrderGroup.CURRENT_NUMBER).setValue(orderObject.orderNumber)
    }
    
    /*
     * Function for get current order number form firebase database
     */
    func getCurrentOrderNumber() ->Int{
        
        return -1;
    }
    
    
    func removeProductFromCartByProductId(){
    }

    func getMenFashionTypeIndex() ->Int{
        
        print("Calling function getMenFahsionTypeIndex......")
        return 0;
    }
    
    func checkIsExistProductInCart(ListProductInCart list:DataSnapshot, Product product: Product) -> Int{
        for child in list.children{
            let _child: DataSnapshot = child as! DataSnapshot
            let productID: Int = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.PRODUCT).childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as! Int
            //print("#################### ID = \(productID)")
            if productID == product.identifier{
                let amount: Int = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.NUMBER_PRODUCT).value as! Int
                return amount
            }
        }
        return -1
    }
    
    func getKeyValueOfObject(ListProduct list:DataSnapshot, Product product: Product) ->String{
        for child in list.children{
            let _child: DataSnapshot = child as! DataSnapshot
            let productID: Int = _child.childSnapshot(forPath: AppCons.CartTableAtrribute.PRODUCT).childSnapshot(forPath: AppCons.ProductTableAttribute.ID).value as! Int
            //print("#################### ID = \(productID)")
            if productID == product.identifier{
                return _child.key
            }
        }
        return ""
    }
    
    func addUserToFirebase(user: User){
        let userJSonObject = toJson(object: user, objectType: .USER_OBJECT)
        databaseReference.child(AppCons.User.TABLE_NAME).childByAutoId().setValue(userJSonObject)
    }
    
    func makeUserOnline(user: User, screen: UIViewController){
        var res = false
        let usersRef = databaseReference.child(AppCons.User.TABLE_NAME)
        let queryRef = usersRef.queryOrdered(byChild: AppCons.User.USER_EMAIL).queryEqual(toValue: user.email)
        
        queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let email = (userSnap.childSnapshot(forPath: AppCons.User.USER_EMAIL).value ?? "") as! String
                let pw = (userSnap.childSnapshot(forPath: AppCons.User.USER_PASSWORD).value ?? "") as! String
                let name = (userSnap.childSnapshot(forPath: AppCons.User.USER_NAME).value ?? "") as! String
                let birthday = (userSnap.childSnapshot(forPath: AppCons.User.USER_BIRTHDAY).value ?? "") as! String
                let sex = (userSnap.childSnapshot(forPath: AppCons.User.USER_GENDER).value ?? "") as! String
                if(email == user.email && pw == user.password){
                    UserDefaults.standard.set(email, forKey: "Email")
                    UserDefaults.standard.set(pw, forKey: "Password")
                    let _user = User(name: name, email: email, birthday: birthday, gender: sex, pass: pw)
                    CurrentUser.shared.setUser(_user)
                    res = true
                }else{
                    res = false
                }
            }
            if(res == true){
                screen.performSegue(withIdentifier: "showHomeViewControllerSegue", sender: self)
            }else{
                let alert = UIAlertController(title: "CÁNH BÁO", message: "Tên đăng nhập hoặc mật khẩu không đúng!!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: nil))
                screen.present(alert, animated: true)
            }
        })
    }
    
}

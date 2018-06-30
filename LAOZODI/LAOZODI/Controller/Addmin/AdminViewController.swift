//
//  AdminViewController.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/27/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage

enum TextFieldType{
   case  PRODUCT_GROUP,SUB_GROUP,PRODUCT_TYPE
}

class PickerViewTag{
    public static let PRODUCT_GROUP_PICKER_VIEW_TAG = 1
    public static let SUB_GROUP_PICKER_VIEW_TAG = 2
    public static let PRODUCT_TYPE_PICKER_VIEW_TAG = 3
}

class AdminViewController: UIViewController {

    

    @IBOutlet weak var tfProductGroup: UITextField!
    @IBOutlet weak var tfSubGroup: UITextField!
    @IBOutlet weak var tfProductType: UITextField!
    
    
    @IBOutlet weak var tfProductName: UITextField!
    @IBOutlet weak var tfProductDescription: UITextField!
    @IBOutlet weak var tfProductPrice: UITextField!
    @IBOutlet weak var tfProductBrand: UITextField!
    @IBOutlet weak var tfProductWarranty: UITextField!
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfProductURLImage: UITextField!
    let productGroupData:[String] = [AppCons.ProductGroupName.MEN_FASHION,
                                     AppCons.ProductGroupName.ELECTRONIC_DEVICE,
                                     AppCons.ProductGroupName.FOODS,
                                     AppCons.ProductGroupName.BABY_TOY_MOTHER]
    
    let manFashionProductGroup:[String] = [AppCons.ManFashionGroupProduct.BOYS_ACCESSORIES,
                                          AppCons.ManFashionGroupProduct.BOYS_OUTFITS,
                                          AppCons.ManFashionGroupProduct.BOYS_SHOES,
                                          AppCons.ManFashionGroupProduct.CHILDREN_BAGS,
                                          AppCons.ManFashionGroupProduct.MEN_ACCESSORIES,
                                          AppCons.ManFashionGroupProduct.MEN_BAGS,
                                          AppCons.ManFashionGroupProduct.MEN_CLOTHING,
                                          AppCons.ManFashionGroupProduct.MEN_SHOES]
    
    let manClothingProductGroup :[String] = [AppCons.ManClothingGroupProduct.COAT,
                                             AppCons.ManClothingGroupProduct.JEANS,
                                             AppCons.ManClothingGroupProduct.POLO_SHIRT,
                                             AppCons.ManClothingGroupProduct.SHIRT,
                                             AppCons.ManClothingGroupProduct.SHORTS,
                                             AppCons.ManClothingGroupProduct.T_SHIRT,
                                             AppCons.ManClothingGroupProduct.VEST]
    
    
    let electronicDevice: [String]  =  [
        AppCons.ElectronicDeviceGroupProduct.MOBILE_PHONE,
        AppCons.ElectronicDeviceGroupProduct.CAMENRA,
        AppCons.ElectronicDeviceGroupProduct.DESKTOP,
        AppCons.ElectronicDeviceGroupProduct.LAPTOP,
        AppCons.ElectronicDeviceGroupProduct.PLAYSTATION,
        AppCons.ElectronicDeviceGroupProduct.SOUND,
        AppCons.ElectronicDeviceGroupProduct.TABLET
                                       ]
    
    
    let electronicProduct :[String] = ["Product"]

    
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        
       
        
        let tapGesTure = UITapGestureRecognizer(target: self, action: #selector(tapProductImage));
        tapGesTure.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesTure)
        
        
        //FirebaseManager.shared.getMenFashionTypeIndex()
        var productGroupPickerView = createPickerViewFor(FiledType: .PRODUCT_GROUP)
        var subGroupPickerView = createPickerViewFor(FiledType: .SUB_GROUP)
        var productTypePickerView = createPickerViewFor(FiledType: .PRODUCT_TYPE)
        
        productGroupPickerView.tag = PickerViewTag.PRODUCT_GROUP_PICKER_VIEW_TAG
        subGroupPickerView.tag = PickerViewTag.SUB_GROUP_PICKER_VIEW_TAG
        productTypePickerView.tag = PickerViewTag.PRODUCT_TYPE_PICKER_VIEW_TAG
        
        productGroupPickerView.delegate = self
        productGroupPickerView.dataSource = self
        
        subGroupPickerView.delegate = self
        subGroupPickerView.dataSource = self
        
        productTypePickerView.delegate = self
        productTypePickerView.dataSource = self
        
    
   
        
        
        
        // Do any additional setup after loading the view.
    }

    func createPickerViewFor(FiledType textFiledType: TextFieldType) -> UIPickerView{
        var pickerView = UIPickerView()
        let toobar = UIToolbar()
        let btnDonde = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil , action: #selector(btnDoneInPickerViewPressed))
      //  let btnCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: pickerView, action: #selector(btnCancelInPickerViewPressed))
        
        toobar.setItems([btnDonde], animated: true)
        //toobar.setItems([btnCancel], animated: true)
        toobar.sizeToFit()
        
        switch textFiledType {
        case .PRODUCT_GROUP:
            self.tfProductGroup.inputAccessoryView = toobar
            self.tfProductGroup.inputView = pickerView
            break
            
        case .SUB_GROUP:
            self.tfSubGroup.inputAccessoryView = toobar
            self.tfSubGroup.inputView = pickerView
            break
            
        case .PRODUCT_TYPE:
            self.tfProductType.inputAccessoryView = toobar
            tfProductType.inputView = pickerView
            break
            
        default:
            break
        }
        
        return pickerView
    }
    
    @objc func btnDoneInPickerViewPressed(){
        view.endEditing(true)
    }
    
    
    @IBAction func btnCreateNewProductPressed(_ sender: Any) {
        
      
        let imageName = UUID().uuidString;
        let firebaseStorageRef =  Storage.storage().reference().child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(self.imageView.image!){
            firebaseStorageRef.putData(uploadData, metadata: nil, completion:{(metaData,error) in
            if error != nil{
                print(error)
                return
            }
            
            if let url = metaData?.downloadURL(){
            
            
                    FirebaseManager.shared.databaseReference.child(AppCons.IdentifierIndexName.MEN_FASHION_ID).observeSingleEvent(of: .value, with: {(snapshot) in
                        var currentId = snapshot.value as! Int
                        print("CURRENT ID : \(currentId)")
                        let productId = currentId + 1
                        FirebaseManager.shared.databaseReference.child(AppCons.IdentifierIndexName.MEN_FASHION_ID).setValue(productId)
                        let productGroup = self.tfProductGroup.text!
                        let subGroup = self.tfSubGroup.text!
                        let productType = self.tfProductType.text!
            
                        let productName = self.tfProductName.text!
                        let productDescription = self.tfProductDescription.text!
                        let productPrice = Int(self.tfProductPrice.text!)!
                        let productBrand = self.tfProductBrand.text!
                        let productWarranty = Int(self.self.tfProductWarranty.text!)!
                        let productURLImage = url.absoluteString
            
                        let product: Product = Product(Identifier: productId, Name: productName, Description: productDescription, Price: productPrice, Brand: productBrand, StrURLImage: productURLImage, Warranty: productWarranty)
            
                        print("product information \(product.brand)")
                        FirebaseManager.shared.addProductToFirebaseDatabase(Product: product, ProductGroup: productGroup, SubGroup: subGroup, ProductType: productType)
                    })
            }
            
            self.dismiss(animated: true, completion: nil)
        })
        }
        
    }
    
//    @objc func btnCancelInPickerViewPressed(){
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    

}

extension AdminViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case PickerViewTag.PRODUCT_GROUP_PICKER_VIEW_TAG:
            return productGroupData.count
        case PickerViewTag.SUB_GROUP_PICKER_VIEW_TAG:
            switch tfProductGroup.text{
            case AppCons.ProductGroupName.MEN_FASHION?:
                return manFashionProductGroup.count
                
            case AppCons.ProductGroupName.ELECTRONIC_DEVICE?:
                return electronicDevice.count
            case AppCons.ProductGroupName.FOODS?:
                return 1
                
            case AppCons.ProductGroupName.BABY_TOY_MOTHER?:
                return 1
            default:
                return -1
            }
            return manFashionProductGroup.count
        case PickerViewTag.PRODUCT_TYPE_PICKER_VIEW_TAG:
            return manClothingProductGroup.count
        default:
            return -1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case PickerViewTag.PRODUCT_GROUP_PICKER_VIEW_TAG:
            return productGroupData[row]
        case PickerViewTag.SUB_GROUP_PICKER_VIEW_TAG:
            switch tfProductGroup.text{
            case AppCons.ProductGroupName.MEN_FASHION?:
                return manFashionProductGroup[row]
            case AppCons.ProductGroupName.ELECTRONIC_DEVICE?:
                return electronicDevice[row]
            case AppCons.ProductGroupName.FOODS?:
                return "Food"
            case AppCons.ProductGroupName.BABY_TOY_MOTHER?:
                return AppCons.CommonAttribute.BABYTOY_MOTHER_SUB_GROUP
            default:
                return nil
            }
            
            return manFashionProductGroup[row]
        case PickerViewTag.PRODUCT_TYPE_PICKER_VIEW_TAG:
            return manClothingProductGroup[row]
        default:
            break
        }
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case PickerViewTag.PRODUCT_GROUP_PICKER_VIEW_TAG:
            tfProductGroup.text = productGroupData[row]
            break
        case PickerViewTag.SUB_GROUP_PICKER_VIEW_TAG:
            switch tfProductGroup.text{
            case AppCons.ProductGroupName.MEN_FASHION?:
                tfSubGroup.text = manFashionProductGroup[row]
                break
            case AppCons.ProductGroupName.ELECTRONIC_DEVICE?:
                tfSubGroup.text = electronicDevice[row]
                break
                
            case AppCons.ProductGroupName.FOODS?:
                tfSubGroup.text  = "Food"
                break
            case  AppCons.ProductGroupName.BABY_TOY_MOTHER?:
                tfSubGroup.text = AppCons.CommonAttribute.BABYTOY_MOTHER_SUB_GROUP
            default:
                break
            }
            break
        case PickerViewTag.PRODUCT_TYPE_PICKER_VIEW_TAG:
            switch tfProductGroup.text{
            case AppCons.ProductGroupName.MEN_FASHION?:
                tfProductType.text = manClothingProductGroup[row]
                break
            case AppCons.ProductGroupName.ELECTRONIC_DEVICE?:
                tfProductType.text = electronicProduct[0]
            case AppCons.ProductGroupName.FOODS?:
                tfProductType.text = "Product"
                break
                
            case AppCons.ProductGroupName.BABY_TOY_MOTHER?:
                tfProductType.text = AppCons.CommonAttribute.PRODUCT
                break
            default:
                break
            }
          
        default:
            break
        }
    }
}

extension AdminViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @objc func tapProductImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage  = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        else if let orginalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = orginalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            imageView.image = selectedImage
        }
        
        
        print("@@@@@@@@@@@@@@@@@@@@@@@@")
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    
    
    
}



//
//  File.swift
//  LAOZODI
//
//  Created by Phạm Anh Tuấn on 5/26/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import Foundation

public class AppCons{
    
    public class IdentifierIndexName{
        public static let MEN_FASHION_ID = "MenFashionId"
        public static let CART_ID = "CartId"
    }
    public class CrawlWebDataDefine{
        public static let LAZADA_URL = "https://www.lazada.vn/ao-khoac-nam/"
        public static let MAXIMUM_PAGES_VISIT = 100
    }
    public class Identify{
        public static let SEARCH_PRODUCT_TABLE_INDENTIFY: String? = "searchProductTable"
        public static let CART_VIEW_CONTROLLER_IDENTIFY: String? = "CartViewControllerID"
        public static let PRODUCT_DEATAIL_VIEW_CONTROLLER_IDENTIFY : String? = "ProductDetailViewControllerID"
    }
    
    public class TableName{
        public static let CART = "Cart"
//        public static let PRODUCT = "Product"
    }
    
    public class CartTableAtrribute {
        public static let PRODUCT = "Product"
        public static let NUMBER_PRODUCT = "Number"
    }
    
    public class ProductGroupName{
        public static let MEN_FASHION = "MenFashion"
        public static let WOMAN_FASHION =  "WomanFashion"
        public static let ELECTRONIC_DEVICE = "ElectronicDevice"
        public static let FOODS = "Foods"
        public static let BABY_TOY_MOTHER = "BabyToyMothers"
    }
    
    public class CommonAttribute{
        public static let BABYTOY_MOTHER_SUB_GROUP =  "BabyToyMother"
        public static let PRODUCT = "Product"
    }

    
    public class ManFashionGroupProduct{
        
        public static let MEN_CLOTHING     = "MenClothing"
        public static let MEN_UNDERWEAR    = "MenUnderwear"
        public static let MEN_SHOES        = "MenShoes"
        public static let MEN_BAGS         = "MenBags"
        public static let MEN_ACCESSORIES  = "MenAccessories"
        public static let BOYS_OUTFITS     = "BoysOutfits"
        public static let BOYS_SHOES       = "BoysShoes"
        public static let BOYS_ACCESSORIES = "BoysAccessories"
        public static let CHILDREN_BAGS    = "ChildrenBags"
        
    }
    
    public class WomanFashionGroupProduct{
    
    }
    
    public class ElectronicDeviceGroupProduct{
        public static let  MOBILE_PHONE =  "MobilePhone"
        public static let TABLET        =  "Tablet"
        public static let LAPTOP        =  "laptop"
        public static let DESKTOP       =  "Desktop"
        public static let SOUND         =  "Sound"
        public static let CAMENRA       =  "Camera"
        public static let PLAYSTATION   =  "PlayStation"
    }
    
    
    
    public class ManClothingGroupProduct{
        public static let COAT = "Coat"
        public static let POLO_SHIRT = "PoloShirt"
        public static let SHIRT = "Shirt"
        public static let T_SHIRT = "TShirt"
        public static let JEANS = "Jeans"
        public static let SHORTS = "Shorts"
        public static let VEST = "Vest"
    }
    
    public class ProductTableAttribute{
        public static let ID = "Id"
        public static let NAME = "Name"
        public static let DESCRIPTION = "Description"
        public static let PRICE = "Price"
        public static let BRAND = "Brand"
        public static let STR_URL_IMAGE = "StrURLImage"
        public static let WARRANTY = "Warranty"
    }

    public enum ObjectType{
        case PRODUCT_OBJECT
        case CART_PRODUCT_OBJECT
        case ORDER_OBJECT
    }
    
    public class OrderGroup{
        public static let ORDER = "Order"
        public static let CURRENT_NUMBER = "CurrentNumber"
    }
    public class OrderObject{
        public static let ORDER_NUMBER = "OrderNumber"
        public static let ORDER_INFO = "OrderInfo"
    }
    
    public class Category{
        public static let PHU_KIEN_DIEN_TU = "PHỤ KIỆN ĐIỆN TỬ"
        public static let SUC_KHOE_LAM_DEP = "SỨC KHOẺ VÀ LÀM ĐẸP"
        public static let THIET_BI_DIEN_TU = "THIẾT BỊ ĐIỆN TỬ"
        public static let THOI_TRANG_NAM = "THỜI TRANG NAM"
        public static let THOI_TRANG_NU = "THỜI TRANG NỮ"
        public static let PHU_KIEN_THOI_TRANG = "PHỤ KIỆN THỜI TRANG"
        public static let THE_THAO_DU_LICH = "THỂ THAO VÀ DU LỊCH"
        public static let OTO_XEMAY = "Ô TÔ XE MÁY"
        public static let DO_CHOI_ME_BE  = "ĐỒ CHƠI MẸ VÀ BÉ"
        public static let DO_AN_HANG_HOA = "ĐỒ ĂN VÀ HÀNG HOÁ"
    }
}

//
//  Product.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 2/7/17.
//  Copyright © 2017 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: BaseObject {
    
    private(set) var imageString:NSString?
    var name:NSString?
    var oid:NSInteger?
    var ename:NSString?
    var eid:NSInteger?
    var saleOff:NSString?
    var isNew:Bool?
    private(set) var priceString:NSString?
    private(set) var priceOldString:NSString?
    private(set) var priceAttribute:NSMutableAttributedString?
    private(set) var priceOldAttribute:NSMutableAttributedString?
    private(set) var totalEstoreString:NSString?
    private(set) var totalOrderString:NSString?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        
    }
}

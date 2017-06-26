//
//  UserInformation.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/1/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInformationEntity: BaseObject {
    var city : NSString?
    var address: NSString?
    var birthday: Date?
    var pricePerUpProduct: NSString?
    var mainMoney: NSString?
    var marketingMoney: NSString?
    var isNhanhPartner: Bool?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        city <- map["getUserByAccessToken.city"]
        address <- map["getUserByAccessToken.address"]
        birthday <- (map["getUserByAccessToken.birthday"],DateTransform())
        pricePerUpProduct <- map["getUserByAccessToken.price_per_up_product"]
        mainMoney <- map["getUserByAccessToken.money_main"]
        marketingMoney <- map["getUserByAccessToken.money_marketing"]
        isNhanhPartner <- map["getUserByAccessToken.is_nhanh_partner"]
    }
}

//
//  User.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/9/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class User: BaseObject {
    var oid : NSString?
    var firstName: NSString?
    var lastName: NSString?
    var avatar: NSString?
    var email: NSString?
    var gender: NSString?
    var phone: NSString?
    var dob: NSString?
    var city: NSString?
    var district: NSString?
    var accessToken: NSString?
    var address: NSString?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        oid <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        avatar <- map["avatar"]
        email <- map["email"]
        gender <- map["gender"]
        phone <- map["phone"]
        dob <- map["dob"]
        city <- map["city"]
        district <- map["district_name"]
        accessToken <- map["access_token"]
        address <- map["address"]
    }
    
    internal func fullname() -> NSString? {
        var _fullName:NSString?
        if firstName != nil {
            _fullName = firstName
        }
        if lastName != nil {
            _fullName?.appending(lastName as! String)
        }
        
        return _fullName
    }
}

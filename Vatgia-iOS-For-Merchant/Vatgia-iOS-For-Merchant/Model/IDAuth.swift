//
//  IDAuth.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/9/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class IDAuth: BaseObject {
    var user : User?
    var token: NSString?
    var nextUrl: NSString?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        user <- map["oid"]
        token <- map["token"]
        nextUrl <- map["next_url"]
    }

}

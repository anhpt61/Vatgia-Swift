//
//  EntityBase.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/1/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseObject: Mappable {
    var errorCode: NSInteger?
    var message: NSString?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        errorCode <- map["error_code"];
        message <- map["message"];
    }
}

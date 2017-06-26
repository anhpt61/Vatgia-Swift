//
//  ContactInfos.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 6/26/17.
//  Copyright © 2017 Tuan Anh Phan. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 {
 data =     (
    {
    avatar = "https://api.papaya.vn/img/post_imgs/avatar/20170609/aD9Kiwygk_1496990695.jpg";
    fullname = XuanXuXu;
    "gamota_id" = 4573;
    username = XuanXuXu;
    },
    {
    avatar = "";
    fullname = pta741;
    "gamota_id" = 109143;
    username = pta741;
    });
 "error_code" = 0;
 message = Success;
 */
class ContactInfos: BaseObject {
    var data : [ContactInfo]?;

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map:map);
        data <- map["data"];
    }
}

class ContactInfo: BaseObject {
    var gamotaid : NSString?
    var fullname: NSString?
    var username: NSString?
    var avatar: NSString?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        gamotaid <- map["gamota_id"]
        fullname <- map["fullname"]
        username <- map["username"]
        avatar <- map["avatar"]
    }
}

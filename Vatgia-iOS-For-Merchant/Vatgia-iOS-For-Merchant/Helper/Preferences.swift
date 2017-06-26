//
//  Preferences.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/1/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

let kUserInfo: String = "user_info";

class Preferences: NSObject {
    var userInfo:UserInformationEntity?{
        willSet{
            print(newValue!.toJSONString(prettyPrint: true)!);
            UserDefaults.standard.set(newValue!.toJSONString(prettyPrint: true), forKey: kUserInfo)
            UserDefaults.standard.synchronize()
        }
        didSet {}
    }
    
    static let sharedInstance = Preferences()
    
    override init() {
        super.init()
        
        let user:NSString? = UserDefaults.standard.object(forKey: kUserInfo) as? NSString
        if let user = user {
            userInfo = Mapper<UserInformationEntity>().map(JSONString: user as String)
            print(userInfo!)
        };


   }
    
}

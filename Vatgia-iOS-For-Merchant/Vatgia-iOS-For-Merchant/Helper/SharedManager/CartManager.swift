//
//  CartManager.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/22/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

struct CartManagerKey {
    static let kBadgeCartNumberNotification = "kBadgeCartNumberNotification"
    static let kPreferenceBadgeCartNumber = "badge_cart_number"
}

class CartManager: NSObject {
    
    static let sharedInstance = CartManager()
    var _badgeCartNumber:NSString?
    
    // MARK: - constructor
    override init() {
        super.init()
        _badgeCartNumber = self.stringForKey(key: CartManagerKey.kBadgeCartNumberNotification as NSString,
                                             defaultValue: "")
        let defaultCenter:NotificationCenter = NotificationCenter.default
        defaultCenter.addObserver(self,
                                  selector: #selector(handleAuthenticationNotification(notification:)),
                                  name: NSNotification.Name(rawValue: UserTrackerKey.kAuthenticationNotification),
                                  object: UserTracker.sharedInstance)
        defaultCenter.addObserver(self,
                                  selector: #selector(handleGraphAccessTokenNotification(notification:)),
                                  name: NSNotification.Name(rawValue: UserTrackerKey.kGraphAccessTokenNotification),
                                  object: UserTracker.sharedInstance)
        defaultCenter.addObserver(self,
                                  selector: #selector(handleApplicationDidBecomeActiveNotification(notification:)),
                                  name: NSNotification.Name.UIApplicationDidBecomeActive,
                                  object: UserTracker.sharedInstance)
       
        self.updateBadgeCartNumber()
        
    }
    
    deinit {
        let defaultCenter:NotificationCenter = NotificationCenter.default
        defaultCenter.removeObserver(self,
                                     name: NSNotification.Name(rawValue: UserTrackerKey.kAuthenticationNotification),
                                     object: UserTracker.sharedInstance)
        defaultCenter.removeObserver(self,
                                     name: NSNotification.Name(rawValue: UserTrackerKey.kGraphAccessTokenNotification),
                                     object: UserTracker.sharedInstance)
        defaultCenter.removeObserver(self,
                                     name: NSNotification.Name.UIApplicationDidBecomeActive,
                                     object: nil)
        
    }
    
    func stringForKey(key:NSString ,defaultValue:NSString) -> NSString {
        let standard:UserDefaults = UserDefaults.standard
        var value = standard.string(forKey: key as String)
        if value == nil{
            value = defaultValue as String
        }
        return value! as NSString
    }
    
    func setString(value:NSString, forkey key:NSString) {
        let standard:UserDefaults = UserDefaults.standard
        standard.set(value, forKey: key as String)
        standard.synchronize()

    }
    // MARK: - destructor
    
    // MARK: - public class methods
    
    func updateBadgeCartNumber() {
        let tracker:UserTracker = UserTracker.sharedInstance
        if tracker.graphAccessToken == nil
        {
            return
        }
        NetworkManager.sharedManager.getCartCount(tracker.graphAccessToken as! String ,completion: { (result) in
            print(result.isSuccess)
        })
        
       
    }
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    func handleAuthenticationNotification(notification:Notification) {
        _badgeCartNumber = "0"
    }
    
    func handleGraphAccessTokenNotification(notification:Notification) {
        self.updateBadgeCartNumber()
    }
    
    func handleApplicationDidBecomeActiveNotification(notification:Notification) {
        self.updateBadgeCartNumber()
    }
    // MARK: - delegate methods
}

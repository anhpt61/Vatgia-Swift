//
//  UserTracker.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/9/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserTrackerKey {
    static let kAuthenticationNotification = "kAuthenticationNotification"
    static let kRegistrationTokenNotification = "kRegistrationTokenNotification"
    static let kGraphAccessTokenNotification = "kGraphAccessTokenNotification"
    static let kGoogleAPIKey = "AIzaSyBSajuzcG0oP7bU7MsWivr9XEbWZdSOH8E"
    static let kPreferenceCurrentUserKey = "current_user"
    static let kPreferenceAccessTokenKey = "access_token"
    static let kPreferenceCookiesKey = "cookies"
    static let kPreferenceAuthenticationKey = "authentication"
    static let kPreferenceLoginDate = "login_date"
    static let kPreferenceLoginType = "login_type"
    static let kPreferenceDeviceTokenKey = "device_token"
    static let kPreferenceRegistrationToken = "registration_token"
    static let kPreferenceRegistrationTokenVchat = "registration_tokenVchat"
    static let kPreferenceSubscribedTagAllKey = "subscribe_tag_all"
    static let kPrefereceSubscribedTagOrderKey = "subscribe_tag_order"
    static let kPreferenceVGUserIdKey = "vg_user_id"
    static let kPreferenceGraphAccessTokenKey = "graph_access_token"
    static let kPreferenceIDCookiesLoaded = "id_cookies_loaded"
    static let kClearCookies = "kClearCookies"
    static let kPreferenceHistoryCatsNotification = "kPreferenceHistoryCatsNotification"
    static let kLoginExpirationDuration = 29 * 24 * 60 * 60
    static let kMaxNumberOfAttemptsSubscribedTagAll = 3
    static let kMaxNumberOfAttemptsSubscribedTagOrder = 3
    static let kMaxNumberOfAttemptsUnsubscribedTagOrder = 3
    static let kMaxNumberOfAttemptsGetGraphAccessToken = 3
    static let kUserTrackerIDCookiesScheme = "cookies"
}

class UserTracker: NSObject {
    
    var user:User?
    var vgUserId:NSInteger?
    var graphAccessToken:NSString?
    
    private(set) var accessToken:NSString?
    {
        willSet{
        
        }
        didSet{
        
        }
    }
    private(set) var authenticated:Bool?
    
    static let sharedInstance = UserTracker()
    
    func initialize() {
        let _user:NSString? = UserDefaults.standard.object(forKey: UserTrackerKey.kPreferenceCurrentUserKey) as? NSString
        if let _user = _user {
            user = Mapper<User>().map(JSONString: _user as String)
        }
        
        let _vgUserId:NSInteger? = UserDefaults.standard.integer(forKey: UserTrackerKey.kPreferenceVGUserIdKey)
        if let _vgUserId = _vgUserId {
            vgUserId = _vgUserId
        }
        
        let _accessToken:NSString? = UserDefaults.standard.object(forKey: UserTrackerKey.kPreferenceAccessTokenKey) as? NSString
        if let _accessToken = _accessToken {
            accessToken = _accessToken
        }
        
        let _authenticated:Bool? = UserDefaults.standard.bool(forKey: UserTrackerKey.kPreferenceAuthenticationKey)
        if let _authenticated = _authenticated {
            authenticated =  _authenticated as Bool
        }
    }
}

//
//  NetworkManager.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/17/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


struct APIBaseURL {
    static let API_SESSION_ERROR_DOMAIN = "com.magicud.error";
    static let API_BASE_URL_STRING = "http://api.vatgia.vn";
    static let TEST_API_BASE_URL_STRING = "http://apitest.vnpgroup.net";
    static let ID_BASE_URL_STRING = "https://id-vatgia-com.appspot.com";
    static let TOUCH_BASE_URL_STRING = "http://touch.vatgia.com";
    static let GRAPTH_BASE_URL_STRING = "http://graph.vatgia.vn";
    static let cTEST_GRAPTH_BASE_URL_STRING = "http://dev1.graph.vatgia.vn";
    static let ID_AUTHORIZATION_HEADER_USERNAME = "vatgia-ios-hoc";
    static let ID_AUTHORIZATION_HEADER_PASSWORD = "AWKQMZATGGEEHUDUYW";
    static let GRAPTH_AUTHORIZATION_HEADER_USERNAME = "ios_giam";
    static let GRAPTH_AUTHORIZATION_HEADER_PASSWORD = "4CAE14AA42DF6DCF751BA91275755FA8";
    static let GCM_BASE_URL_STRING = "https://vnp-ns.appspot.com";
    static let VNPNS2_BASE_URL_STRING = "https://vnpns2.appspot.com";
    static let DEBUG_GCM_BASE_URL_STRING = "https://beta-dot-vnp-ns.appspot.com";
    static let GCM_CRM_BASE_URL_STRING = "https://vnp-crm.appspot.com";
    static let CHAT_API_ID = "ios";
    static let HAT_API_PASSWORD = "vl9ihkjdJdd)d8fjsnngfahhfglcJgdfgnHbfgHBjfg";
    static let CHAT_BASE_URL_STRING = "http://vchat.vn";
    static let SEND_CHAT_BASE_URL_STRING = "http://live.vnpgroup.net";
    static let MY_AD_BASE_URL_STRING = "http://ad.vatgia.com";
    static let RE_BASE_URL_STRING = "http://re.vnpid.com";
    static let CHAT_API_URL_BASE = "https://api.papaya.vn";
    
    

}

struct APIPath {
    static let login = "_ah/api/auth/v1/via_password"
    static let getCartCount = "v1/cart"
    static let getContact = "/api/contacts"
}

struct APIKey {
    static let username = "username"
    static let password = "password"
    static let image = "image"
    static let accessToken = "access_token"
    static let iPro = "access_token"
    static let fullEstore = "access_token"
    static let eName = "access_token"
    static let iEst = "iEst"
    static let token = "token"

}

class NetworkManager: SessionManager {
    static let sharedManager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 30.0
        
        return NetworkManager(configuration: configuration)
    }()
    
    // 1. Login
    func signinWithEmail(_ username: String, password: String, completion: @escaping (_ result: Result<IDAuth>) -> Void) {
        let path = APIBaseURL.ID_BASE_URL_STRING + APIPath.getCartCount
        let params = [APIKey.username: username,
                      APIKey.password: password]
        
        self.requestWithMethod(.post, fullUrl: path, params: params as [String : AnyObject]?, completion: completion)
    }
    
    // 1. Login
    func getContact(_ tokenStr: String ,completion: @escaping (_ result:Result<ContactInfos> ) -> Void) {
        let path = APIBaseURL.CHAT_API_URL_BASE + APIPath.getContact
        let params = [APIKey.token: tokenStr]
        
        self.requestWithMethod(.get, fullUrl: path, params: params as [String : AnyObject]?, completion: completion)
    }
    
    // 1. Login
    
    func getCartCount(_ graphAccessTokenString: String, completion: @escaping (_ result: Result<IDAuth>) -> Void){
        let path = APIBaseURL.GRAPTH_BASE_URL_STRING + APIPath.login
        let params = [APIKey.accessToken: graphAccessTokenString]
        
        self.requestWithMethod(.post, fullUrl: path, params: params as [String : AnyObject]?, completion: completion)
    }
    
    func getHybridProduct(_ product: Product, completion: @escaping (_ result: Result<HybridProduct>) -> Void){
        let path = APIBaseURL.GRAPTH_BASE_URL_STRING + APIPath.login
        let params = [APIKey.iPro: String.init(format: "%ld", product.oid!),
                      APIKey.fullEstore:"0",
                      APIKey.eName: (product.ename?.length)! > 0 ? product.ename!: "",
                      APIKey.iEst: product.eid != nil ? String.init(format: "%ld", product.eid!) : "",
                      ] as [String : Any]
        
        return self.requestByUploadData(.post, fullUrl: path, params: params as [String : AnyObject]?, images:nil, completion: completion);
    }
    
    // MARK: Private
    fileprivate func requestWithMethod<T:BaseObject>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, completion: @escaping (_ result: Result<T>) -> Void) {
        
        self.requestWithMethod(method, fullUrl: fullUrl, params: params, encoding: Alamofire.URLEncoding.default, completion: completion)
    }
    
    fileprivate func requestByUploadData<T:BaseObject>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, images: [UIImage]?, completion: @escaping (_ result: Result<T>) -> Void) {
  
        return self.uploadWithMethod(method, fullUrl: fullUrl, params: params, images: images, completion: completion)
    }
    
    fileprivate func requestWithMethod<T:BaseObject>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, encoding: ParameterEncoding, completion: @escaping (_ result: Result<T>) -> Void) {
        let url = URL(string: fullUrl)
        if let url = url {
            
            self.session.configuration.httpAdditionalHeaders = ["Authorization": ""];
            self.request(url, method: method, parameters: params, encoding: encoding, headers: nil)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json","text/html"])
                .responseObject(completionHandler: { (response: DataResponse<T>) in
                    if (response.result.isFailure || response.response?.statusCode != 200) {
                        debugPrint("HTTP request error \(String(describing: response.result.error?.localizedDescription))")
                        if let statusCode = response.response?.statusCode {
                            let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                            debugPrint("HTTP response error with message " + errorMessage)
                        }
                    }
                    completion(response.result) // Return result only
                    debugPrint(response.result.value as Any)
                })
        }
    }
    
    fileprivate func uploadWithMethod<T:BaseObject>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, images: [UIImage]?, completion: @escaping (_ result: Result<T>) -> Void) {
        let url = URL(string: fullUrl)
        if url != nil {
            self.upload(multipartFormData: { (formData) in
                if let params = params {
                    for (key, value) in params {
                        if let value = value as? String { // String value
                            if let data = value.data(using: String.Encoding.utf8) {
                                formData.append(data, withName: key)
                            }
                        } else if value is NSNumber { // NSNumber value
                            if let data = "\(value)".data(using: String.Encoding.utf8){
                                formData.append(data, withName: key)
                            }
                        }
                    }
                }
                for image in images! {
                    if let imageData = UIImageJPEGRepresentation(image, 0.6) {
                        formData.append(imageData, withName: APIKey.image, mimeType: "image/jpeg")
                    }
                }
                debugPrint(formData.contentType)
            }, to: fullUrl, encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.validate(statusCode: 200..<500)
                    upload.validate(contentType: ["application/json","text/html"])
                    upload.responseObject{(response: DataResponse<T>) in
                        if (response.result.isFailure || response.response?.statusCode != 200) {
                            debugPrint("HTTP request error \(String(describing: response.result.error?.localizedDescription))")
                            if let statusCode = response.response?.statusCode {
                                let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                                debugPrint("HTTP response error with message " + errorMessage)
                            }
                        }
                        completion(response.result) // Return result only
                        debugPrint(response.result.value as Any)

                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
        }
    }
}

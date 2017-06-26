//
//  ManageProductViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/10/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ManageProductViewController: BaseViewController {
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func fetchData() {
        var jsonData = Data()
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: ["getUserByAccessToken":[]], options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(jsonData, withName: "data")
        }, to: "http://api.vatgia.vn/vg_sevices_out/estore/?access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVzZXJfaWQiOjMyNTc4NTIsImVtYWlsIjoidHJhbm9hbmhrNjFiQGdtYWlsLmNvbSIsImxvZ2lubmFtZSI6ImRlbW8zOCIsInNzb19pZCI6Mjg1MjA1MX0sImNsaWVudCI6eyJ1c2VybmFtZSI6Imlvc19naWFtIiwicm9sZSI6eyJhY2Nlc3NfdG9rZW4iOnsicmVxdWlyZSI6ZmFsc2V9fX0sInRpbWUiOjE0Nzc0Njg4NDMsImV4cCI6MTQ5MzAyMDg0M30.usaDmjUnk1oPVOU3GZFDBCTMGW1-4xTHnVW29v4Evdc", encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.request!)  // original URL request
                    print(response.response!) // URL response
                    print(response.data!)     // server data
                    print(response.result.value!)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                            let user = Mapper<UserInformationEntity>().map(JSONObject: response.result.value)
                            Preferences.sharedInstance.userInfo = user
                            print(user!)
                        }
                        else  {
                            if let _ = response.result.value as? Error {
                                
                            }
                        }
                    case .failure(let error):
                        debugPrint("getEvents error: \(error)")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                
            }
        })
        
        
        
//                    Alamofire.request("http://api.vatgia.vn/vg_sevices_out/estore/?access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7InVzZXJfaWQiOjMyNTc4NTIsImVtYWlsIjoidHJhbm9hbmhrNjFiQGdtYWlsLmNvbSIsImxvZ2lubmFtZSI6ImRlbW8zOCIsInNzb19pZCI6Mjg1MjA1MX0sImNsaWVudCI6eyJ1c2VybmFtZSI6Imlvc19naWFtIiwicm9sZSI6eyJhY2Nlc3NfdG9rZW4iOnsicmVxdWlyZSI6ZmFsc2V9fX0sInRpbWUiOjE0Nzc0Njg4NDMsImV4cCI6MTQ5MzAyMDg0M30.usaDmjUnk1oPVOU3GZFDBCTMGW1-4xTHnVW29v4Evdc",
//                                  method: .post,
//                                  parameters: nil,
//                                  encoding: URLEncoding.default,
//                                  headers: [
//                                    "Accept": "text/html , application/json"
//                                ])
//                    .responseJSON { response in
//                        print(response.request)
//                        print(response.response)
//                        print(response.result)
//        
//                        if let JSON = response.result.value {
//                            print("Did receive JSON data: \(JSON)")
//                        }
//                        else {
//                            print("JSON data is nil.")
//                        }
//        
//                }
        
    }

    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
   

}

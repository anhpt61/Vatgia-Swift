//
//  StoryboardManager.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/10/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class StoryboardManager: NSObject {
    
    var storyboard:UIStoryboard?
    
    static let defaultManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Defaults")
        return instance
    }()
    
    static let homeManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Home")
        return instance
    }()
    
    static let searchManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Search")
        return instance
    }()
    
    static let notificationManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Notifications")
        return instance
    }()
    
    static let profileManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Profile")
        return instance
    }()
    
    static let manageProductManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "ManageProduct")
        return instance
    }()
    
    static let errorManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Error")
        return instance
    }()
    
    static let reportManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Report")
        return instance
    }()
    
    // MARK: - constructor

    convenience init(storyboardName:NSString){
        self.init()
        storyboard = UIStoryboard.init(name: storyboardName as String, bundle: nil)
    }
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    // MARK: - public instance methods
    func instantiateViewControllerWithIdentifier(identifier:NSString) -> UIViewController  {
        return (storyboard?.instantiateViewController(withIdentifier: identifier as String))!
    }
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
}

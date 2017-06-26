//
//  MyTabBarViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/9/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class MyTabBarViewController: UITabBarController {
    
    var _homeNavigationController:MyNavigationViewController?
    var _homeViewController:HomeViewController?
    
    var _searchNavigationController:MyNavigationViewController?
    var _searchViewController:SearchViewController?
    
    var _notificationNavigationController:MyNavigationViewController?
    var _notificationViewController:NotificationViewController?
    
    var _profileNavigationController:MyNavigationViewController?
    var _profileViewController:ProfileViewController?
    
    static var sharedInstance:MyTabBarViewController?
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTabBarViewController.sharedInstance = self
        self.configureViewControllers()
        self.configureTabbarItems()
        
//        let image:UIImage = UIImage.init(named: "ic_bg_tabbar.png")!;
//        UITabBar.appearance().backgroundImage = image
        UITabBar.appearance().shadowImage = UIImage.init()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    func configureViewControllers() {
        _homeNavigationController = StoryboardManager.defaultManager.instantiateViewControllerWithIdentifier(identifier:"my_navigation_controller") as? MyNavigationViewController
        _homeViewController = StoryboardManager.homeManager.instantiateViewControllerWithIdentifier(identifier:"home_page_view_controller") as? HomeViewController
        _homeNavigationController?.viewControllers = [_homeViewController!]
        
        _searchNavigationController = StoryboardManager.defaultManager.instantiateViewControllerWithIdentifier(identifier:"my_navigation_controller") as? MyNavigationViewController
        _searchViewController = StoryboardManager.searchManager.instantiateViewControllerWithIdentifier(identifier:"search_view_controller") as? SearchViewController
        _searchNavigationController?.viewControllers = [_searchViewController!]

        _notificationNavigationController = StoryboardManager.defaultManager.instantiateViewControllerWithIdentifier(identifier:"my_navigation_controller") as? MyNavigationViewController
        _notificationViewController = StoryboardManager.notificationManager.instantiateViewControllerWithIdentifier(identifier:"notification_view_controller") as? NotificationViewController
        _notificationNavigationController?.viewControllers = [_notificationViewController!]

        _profileNavigationController = StoryboardManager.defaultManager.instantiateViewControllerWithIdentifier(identifier:"my_navigation_controller") as? MyNavigationViewController
        _profileViewController = StoryboardManager.profileManager.instantiateViewControllerWithIdentifier(identifier:"profile_view_controller") as? ProfileViewController
        _profileNavigationController?.viewControllers = [_profileViewController!]
        self.viewControllers = [
            _homeNavigationController!,
            _searchNavigationController!,
            _notificationNavigationController!,
            _profileNavigationController!
        ]
        

    }

    func configureTabbarItems() {

        var attributes = [NSForegroundColorAttributeName: UIColor.init(hex: "#868a9a"),
                          NSFontAttributeName : UIFont.init(name: "HelveticaNeue-Light", size:12.0)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
        attributes = [NSForegroundColorAttributeName: UIColor.init(hex: "#ff672d"),
                      NSFontAttributeName : UIFont.init(name: "HelveticaNeue-Light", size: 12.0)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        
        let tabBar:UITabBar = self.tabBar
        let items = tabBar.items
        var item:UITabBarItem?
        
        item = items?[0]
        item?.title = NSLocalizedString("home", comment: "")
        item?.image = UIImage.init(named: "ic_tabbar_normal_home")?.withRenderingMode(.alwaysOriginal)
        item?.selectedImage = UIImage.init(named: "ic_tabbar_selected_home")?.withRenderingMode(.alwaysOriginal)
        
        item = items?[1]
        item?.title = NSLocalizedString("search", comment: "")
        item?.image = UIImage.init(named: "ic_tabbar_normal_search")?.withRenderingMode(.alwaysOriginal)
        item?.selectedImage = UIImage.init(named: "ic_tabbar_selected_search")?.withRenderingMode(.alwaysOriginal)
        
//        item = items?[2]
//        item?.title = NSLocalizedString("profile", comment: "")
//        item?.image = UIImage.init(named: "ic_tabbar_normal_profile")?.withRenderingMode(.alwaysOriginal)
//        item?.selectedImage = UIImage.init(named: "ic_tabbar_selected_profile")?.withRenderingMode(.alwaysOriginal)
        
        item = items?[2]
        item?.title = NSLocalizedString("notifications", comment: "")
        item?.image = UIImage.init(named: "ic_tabbar_normal_notification")?.withRenderingMode(.alwaysOriginal)
        item?.selectedImage = UIImage.init(named: "ic_tabbar_selected_notification")?.withRenderingMode(.alwaysOriginal)
        
        item = items?[3]
        item?.title = NSLocalizedString("profile", comment: "")
        item?.image = UIImage.init(named: "ic_tabbar_normal_profile")?.withRenderingMode(.alwaysOriginal)
        item?.selectedImage = UIImage.init(named: "ic_tabbar_selected_profile")?.withRenderingMode(.alwaysOriginal)
    }

    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    // MARK: - UITabBarDelegate methods
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}

//
//  MyNavigationViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/9/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class MyNavigationViewController: UINavigationController ,UIGestureRecognizerDelegate{
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image:UIImage = UIImage.init(named: "ic_back")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationBar.backIndicatorImage = image
        self.navigationBar.backIndicatorTransitionMaskImage = image
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.hidesBottomBarWhenPushed = true

        if MyTabBarViewController.sharedInstance?.selectedIndex == 2 {
            MyTabBarViewController.sharedInstance?.selectedIndex = 0
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer{
            if self.viewControllers.count < 1{
                return false
            }
            return true
        }
        return false
    }
    
    

}

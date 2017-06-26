//
//  MainNavigationController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/10/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire

class MainNavigationController: MyNavigationViewController, AppReportViewControllerDelegate {
    
    static let sharedInstance = MainNavigationController()
    fileprivate var _errorInternetViewController:UIViewController?
    fileprivate var _showingAppReport:Bool?
    var _justCheckNetwork:Bool?
    
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _errorInternetViewController = StoryboardManager.errorManager.instantiateViewControllerWithIdentifier(identifier: "error_internet_view_controller")
        _justCheckNetwork = true
        self.checkNetwork()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool
    {
        return true;
    }
    
    // MARK: - public instance methods
    
    func checkNetwork() {
        let net = NetworkReachabilityManager()
        net?.startListening()
        net?.listener = { [weak self] status in
            let strongSelf = self
            switch status {
            case .notReachable,.unknown:
                strongSelf?.showErrorInternet()
                break;
            default:
                if strongSelf?._justCheckNetwork == true{
                    strongSelf?.hideErrorInternet()
                }
                else
                {
                    strongSelf?.updateContentViewController()
                }
                strongSelf?.hideErrorInternet()
                break;
                
            }
            
        }
    }
    // MARK: - private instance methods
    func showErrorInternet() {
        var navigationController:UINavigationController = self
        while (navigationController.presentedViewController != nil) && (navigationController.presentedViewController?.isKind(of: UINavigationController.self))! {
            navigationController = navigationController.presentedViewController as! UINavigationController
        }
        
        navigationController.present(_errorInternetViewController!,
                                     animated: true,
                                     completion: nil)
    }
    
    func hideErrorInternet() {
        _errorInternetViewController?.dismiss(animated: true, completion: nil)
    }
    
    func updateContentViewController() {
        let contentViewController:ContentViewController = self.topViewController as! ContentViewController
        if contentViewController.responds(to:#selector(ContentViewController.refreshData)) {
            contentViewController.refreshData()
        }
    }
    
    /**
     * find top view controller, count presenting view controller
     */
    
    func findCurrentTopViewController() -> UIViewController {
        var viewController:UIViewController = self
        
        while true {
            if (viewController.presentedViewController != nil)
            {
                viewController = viewController.presentedViewController!
                continue;
            }
            
            if viewController.isKind(of: UINavigationController.self) {
                let navigationController:UINavigationController = viewController as! UINavigationController
                if navigationController.viewControllers.count <= 0 {
                    return navigationController
                }
                let topViewController:UIViewController = navigationController.viewControllers.last!
                if topViewController.presentedViewController != nil {
                    viewController = topViewController.presentedViewController! as UIViewController
                    continue
                }
                return viewController
            }
            return viewController
        }
    }
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    // MARK: - motion detection
   
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if _showingAppReport! && motion != UIEventSubtype.motionShake {
            return
        }
        
        _showingAppReport = true
        let viewController:UIViewController = self.findCurrentTopViewController()
        let image:UIImage = (viewController.view.image_capture())!
        
        let navigationController:MyNavigationViewController = StoryboardManager.defaultManager.instantiateViewControllerWithIdentifier(identifier: "my_navigation_controller") as! MyNavigationViewController
        let reportViewController:AppReportViewController = StoryboardManager.reportManager.instantiateViewControllerWithIdentifier(identifier: "app_report_view_controller") as! AppReportViewController
        reportViewController.delegate = self
        reportViewController.image = image
        navigationController.viewControllers = [reportViewController]

        reportViewController.interactiveTransition.present(navigationController, from: viewController, withInteractiveEnabled: true)
    }
    
    // MARK: - AppReportViewControllerDelegate
    func appReportViewControllerDidClose(viewController: AppReportViewController) {
        _showingAppReport = false
    }
    
    func appReportViewControllerDidSendReport(viewController: AppReportViewController) {
        _showingAppReport = false
    }
    
    
}

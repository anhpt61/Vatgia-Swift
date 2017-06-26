//
//  AppReportViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/11/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

@objc protocol AppReportViewControllerDelegate {
    @objc optional func appReportViewControllerDidClose(viewController:AppReportViewController)
    @objc optional func appReportViewControllerDidSendReport(viewController:AppReportViewController)
}

class AppReportViewController: UIViewController {

    
    weak var delegate : AppReportViewControllerDelegate?
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

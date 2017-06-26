//
//  InitialViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 10/30/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

let kLaunchViewControllerAnimationDuration: TimeInterval = 0.35;
let kLaunchViewControllerNumberOfAnimationLoop: NSInteger = 3;

@objc protocol InitialViewControllerDelegate {
    @objc optional func initialViewControllerDidFinish(viewController:InitialViewController)
}
class InitialViewController: UIViewController,CAAnimationDelegate {

    weak var delegate : InitialViewControllerDelegate?
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finish()
        let view : UIView? = self.view.viewWithTag(1001);
        let mascotImageView : UIImageView? = view?.viewWithTag(1002) as? UIImageView
        
        let animation:CABasicAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        animation.delegate = self;
        animation.repeatCount = Float(kLaunchViewControllerNumberOfAnimationLoop);
        animation.autoreverses = true
        animation.duration = kLaunchViewControllerAnimationDuration
        animation.fromValue = 0
        animation.toValue = -10.0
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut);
        animation.isRemovedOnCompletion = true;
        mascotImageView?.layer.add(animation, forKey: "animation_mascot")
       
             
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    func finish()
    {
        delegate?.initialViewControllerDidFinish?(viewController: self)
    }
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    // MARK: - CAAnimationDelegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == false {
            return
        }
        self.finish()
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

//
//  InlineProductsViewController.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 2/7/17.
//  Copyright © 2017 Tuan Anh Phan. All rights reserved.
//

import UIKit

class InlineProductsViewController: InlineViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private var _ivTitle: UIImageView?
    @IBOutlet private var _lbTitle: UILabel?
    @IBOutlet private var _lbSubtitle: UILabel?
    @IBOutlet private var _vDivider: UIView?
    @IBOutlet private var _ivArrow: UIImageView?
    @IBOutlet private var _lcVTitleHeight: NSLayoutConstraint?
    @IBOutlet private var _aivLoading: UIActivityIndicatorView?
    @IBOutlet private var _collectionView: UICollectionView?
    @IBOutlet private var _lcCollectionViewHeight: NSLayoutConstraint?
    
    private var _metricCell:InlineProductCollectionViewCell?
    private var _products:NSArray?
    private var _productManager:ProductManager?
    private var _productType:ProductType?
    
    var productType:ProductType?
    private(set) var productTitle:NSString?
    var titleImage:UIImage?
    var titleColor:UIColor?
    var subtitleColor:UIColor?
    var dividerColor:UIColor?
    var arrowImage:UIImage?
    var catId:NSInteger?
    var products:NSArray?
    var ename:NSString?
    var product:Product?
    var hybridProduct:HybridProduct?
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var title:String?;
        var image:UIImage?;
        
        switch _productType! {
        case ProductType.kNewProduct:
            title = NSLocalizedString("new_products",comment: "");
        case ProductType.kBestSellerProduct:
            image = UIImage.init(named: "ic_home_bestseller_title");
            _lbTitle?.textColor = UIColor.init(hex: "0xB55252");
            title = NSLocalizedString("hints_for_you", comment:"");
        default:
            break;
        }
        
        _lbTitle?.text = title;
        _ivTitle?.image = image;
        productTitle = title as NSString?;
        
        if titleImage != nil {
            _ivTitle?.image = titleImage;
        }
        if titleColor != nil {
            _lbTitle?.textColor = titleColor;
        }
        if subtitleColor != nil {
            _lbSubtitle?.textColor = subtitleColor;
        }
        if dividerColor != nil {
            _vDivider?.backgroundColor = dividerColor;
        }
        if arrowImage != nil {
            _ivArrow?.image = arrowImage;
        }
        
        _collectionView?.scrollsToTop = false;
        _collectionView?.isDirectionalLockEnabled = true;
        
        let defaultCenter:NotificationCenter = NotificationCenter.default
        defaultCenter.addObserver(self,
                                  selector: #selector(preferenceHistoryCatsNotification),
                                  name: NSNotification.Name(rawValue: UserTrackerKey.kAuthenticationNotification),
                                  object: UserTracker.sharedInstance)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - BaseViewController
    
    override func refreshData() {
        self.resetData();
        self.loadData();
    }
    
    override func resetData() {
        super.resetData();
        
        _products = nil;
        _productManager = nil;
    }
    
    override func loadData() {
        
        self.fetchData();
    }
    
    override func fetchData() {
        
    }
    // MARK: - public instance methods
    
    // MARK: - private instance methods
    func preferenceHistoryCatsNotification(notification:NSNotification) {
        
    }
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
    // MARK: - UICollectionView methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell.init();
        return cell;
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

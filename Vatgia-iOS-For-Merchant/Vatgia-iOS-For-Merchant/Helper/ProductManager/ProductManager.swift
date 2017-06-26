//
//  ProductManager.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 2/7/17.
//  Copyright © 2017 Tuan Anh Phan. All rights reserved.
//

import UIKit

class ProductManager: NSObject {
    private var _products:NSMutableArray?;
    private var _forwardProductIndex:NSInteger?;
    private var _updatingForwardProductIndex:NSInteger?;
    private var _backwardProductIndex:NSInteger?;
    private var _updatingBackwardProductIndex:NSInteger?;
    
    private var _hybridProductLookup:NSMutableDictionary?;
    private var _ssgLookup:NSMutableDictionary?;
    private var _forwardTask:URLSessionTask?;
    private var _backwardTask:URLSessionTask?;
    private var _loading:Bool?;
    
    var delay:Bool?;
    var tag:String?;
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    deinit {
        self.stop();
        let defaultCenter:NotificationCenter = NotificationCenter.default
        defaultCenter.removeObserver(self,
                                  name: NSNotification.Name(rawValue: UserTrackerKey.kAuthenticationNotification),
                                  object: UserTracker.sharedInstance);
    }
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override init() {
        super.init();
    }
    
    convenience init(delay:Bool) {
        self.init();
        self.delay = delay;
        _forwardProductIndex = -1;
        _updatingForwardProductIndex = -1;
        _backwardProductIndex = -1;
        _updatingBackwardProductIndex = -1;
        self.resetLookup();
        if self.delay == true {
            _loading = false
        }
        else{
            _loading = true;
        }
        
        let defaultCenter:NotificationCenter = NotificationCenter.default
        defaultCenter.addObserver(self,
                                  selector: #selector(handleAuthenticationNotification),
                                  name: NSNotification.Name(rawValue: UserTrackerKey.kAuthenticationNotification),
                                  object: UserTracker.sharedInstance);
        
    }
    
    // MARK: - public instance methods
    
    func addProduct(products:NSArray) {
        if products.count == 0 {
            return;
        }
        
        let product:Product = products[0] as! Product;
        
        if products.contains(product) {
            return;
        }
        let productsLoaded:Bool = self.isProductsLoaded();
        let currentProductCount:NSInteger = _products!.count;
        _products?.addObjects(from: products as! [NSArray]);
        if productsLoaded {
            _forwardProductIndex = currentProductCount;
            _backwardProductIndex = _products!.count - 1;
            if _loading! {
                self.fetchForwardProduct();
                self.fetchBackwardProduct();
            }
        }
        
    }
    
    func replaceProduct(_ oldProduct:Product, _ newProduct:Product) {
        _products!.replaceObject(at: _products!.index(of: oldProduct), with: newProduct);
    }
    
    func updateNextForwardProductIndexFromIndex( index:NSInteger) {
        var index = index
        let currentForwardProductIndex = _backwardProductIndex;
        while true {
            index += 1;
            if index > _products!.count {
                index = 0;
            }
            if index == currentForwardProductIndex {
                break;
            }
            let product:Product = _products![index] as! Product;
            if !self.lookupDataWithProduct(product) {
                break;
            }
        }
        if index == currentForwardProductIndex {
            _forwardProductIndex = -1;
        }
        else{
            _forwardProductIndex = index;
        }
    }
    
    func updateNextBackwardProductIndexFromIndex( index:NSInteger) {
        var index = index
        let currentBackwardProductIndex = _backwardProductIndex;
        while true {
            index -= 1;
            if index < 0 {
                index = _products!.count - 1;
            }
            if index == currentBackwardProductIndex {
                break;
            }
            let product:Product = _products![index] as! Product;
            if !self.lookupDataWithProduct(product) {
                break;
            }
        }
        if index == currentBackwardProductIndex {
            _backwardProductIndex = -1;
        }
        else{
            _backwardProductIndex = index;
        }
    }
    
    func stop() {
        
    }
    
    // MARK: - private instance methods
    
    func fetchForwardProduct() {
        if(_forwardProductIndex! >= 0 && _forwardProductIndex! < _products!.count)
        {
            let product:Product = _products![_forwardProductIndex!] as! Product;
            if self.lookupDataWithProduct(product) {
                self.updateNextForwardProductIndexFromIndex(index: _forwardProductIndex!)
                return;
            }
            requestDataWithProduct(product, completion: { (data, error) in
                if(self._updatingForwardProductIndex! >= 0){
                    self.updateNextForwardProductIndexFromIndex(index: self._updatingForwardProductIndex!)
                    self._updatingForwardProductIndex = -1;
                }
                 else {
                    self.updateNextForwardProductIndexFromIndex(index: self._forwardProductIndex!);
                }
                if(error != nil || error?.code != NSURLErrorCancelled){
                    self.fetchForwardProduct();
                }
            })
        }
    }
    
    func fetchBackwardProduct() {
        if(_backwardProductIndex! >= 0 && _backwardProductIndex! < _products!.count)
        {
            let product:Product = _products![_backwardProductIndex!] as! Product;
            if self.lookupDataWithProduct(product) {
                self.updateNextBackwardProductIndexFromIndex(index: _backwardProductIndex!)
                return;
            }
            requestDataWithProduct(product, completion: { (data, error) in
                if(self._updatingBackwardProductIndex! >= 0){
                    self.updateNextBackwardProductIndexFromIndex(index: self._updatingBackwardProductIndex!)
                    self._updatingBackwardProductIndex = -1;
                }
                else {
                    self.updateNextBackwardProductIndexFromIndex(index: self._backwardProductIndex!);
                }
                if(error != nil || error?.code != NSURLErrorCancelled){
                    self.fetchBackwardProduct();
                }
            })
        }
    }
    
    func isProductsLoaded() -> Bool {
        for product in _products!
        {
            if self.lookupDataWithProduct(product as! Product) == false {
                return false;
            }
        }
        return true;
    }
    
    func lookupDataWithProduct(_ product:Product) -> Bool{
        return true;
    }
    
    func requestDataWithProduct(_ product: Product, completion: @escaping (_ result: NSData?, _ error: NSError?) -> Void )
    {
        NetworkManager.sharedManager.getHybridProduct(product, completion: { (result) in
            if result.isSuccess {
                
            } else {
                
            }
            self.fetchBackwardProduct();
        })

    }
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    func handleAuthenticationNotification(notification:NSNotification){
        
    }
    
    // MARK: - delegate methods
    
    
    func resetLookup() {
        _hybridProductLookup = NSMutableDictionary.init();
        _ssgLookup = NSMutableDictionary.init();
    }
    
    
}


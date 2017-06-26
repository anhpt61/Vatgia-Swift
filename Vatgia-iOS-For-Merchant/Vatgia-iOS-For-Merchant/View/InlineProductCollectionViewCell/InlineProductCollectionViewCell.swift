//
//  InlineProductCollectionViewCell.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 2/7/17.
//  Copyright © 2017 Tuan Anh Phan. All rights reserved.
//

import UIKit

class InlineProductCollectionViewCell: AutoSizeCollectionViewCell {
    @IBOutlet private var _imageView: UIImageView?
    @IBOutlet private var _lbName: UILabel?
    @IBOutlet private var _lbPrice: UILabel?
    @IBOutlet private var _vPriceOld: UIView?
    @IBOutlet private var _lbPriceOld: UILabel?
    
    @IBOutlet private var _vTag: UIView?
    @IBOutlet private var _ivTag: UIImageView?
    @IBOutlet private var _lbSaleOff: UILabel?
    
    private var _product: Product?
    
    var product: Product?
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func autosize_layoutSubviews() {
        super.autosize_layoutSubviews()
        _lbName?.preferredMaxLayoutWidth = self.bounds.width;
        _lbPrice?.preferredMaxLayoutWidth = self.bounds.width;
        _lbPriceOld?.preferredMaxLayoutWidth = self.bounds.width;
    }
    
    // MARK: - public instance methods
    
    func updateDataWithProduct(product:Product,_productType type:ProductType) {
        _product = product;
        if metricCell == nil {
            let url = URL(string: (_product?.imageString as? String)!);
            _imageView?.sd_setImage(with: url, placeholderImage: nil);
        }
        
        _lbName?.text = product.name as? String;
        _lbName?.sizeToFit();
        
        _vTag?.isHidden =  true
        
        if (_product?.saleOff) != nil {
            _vTag?.isHidden = false;
            _ivTag?.image = UIImage.init(named: "ic_sale_up_product_cell");
            _lbSaleOff?.text = _product?.saleOff as? String;
        }
        else if _product?.isNew == false{
            _vTag?.isHidden = false;
            _ivTag?.image = UIImage.init(named: "ic_sale_up_product_cell");
            _lbSaleOff?.text = "";
        }
        
        if type == ProductType.kFashionProduct{
            _lbPrice?.text = _product?.priceString as? String;
        }
        else{
            _lbPrice?.attributedText = _product?.priceAttribute;
        }
        
        _lbPrice?.sizeToFit();
        
        if type == ProductType.kHomeTopSellerProduct
        {
            _vPriceOld?.isHidden = false;
            _lbPriceOld?.text = _product?.totalEstoreString as? String;
        }
        else if type == ProductType.kHomeTopSellProduct {
            _vPriceOld?.isHidden = false;
            _lbPriceOld?.text = _product?.totalOrderString as? String;
        }
        else if (_product?.priceOldAttribute) != nil{
            _vPriceOld?.isHidden = false;
            _lbPriceOld?.attributedText = _product?.priceOldAttribute;
            _lbPriceOld?.sizeToFit();
        }
        else{
            _vPriceOld?.isHidden = true;
            _lbPriceOld?.attributedText = nil;
        }
        
    }
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
}

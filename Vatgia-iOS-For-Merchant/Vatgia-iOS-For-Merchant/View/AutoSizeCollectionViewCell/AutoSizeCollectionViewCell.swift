//
//  AutoSizeCollectionViewCell.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 12/23/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

class AutoSizeCollectionViewCell: UICollectionViewCell {
    private var _metricCell : Bool?
    @IBOutlet var _metricConstraints:[NSLayoutConstraint]?
    
    var metricCell:Bool?
    
    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0 {
            self.layoutIfNeeded()
        }
        self.autosize_layoutSubviews()
    }
    
    // MARK: - public instance methods
    
    
    func autosize_calculateWidthOfCellWithSize(size:CGSize) -> CGFloat {
        var size = size
        self.setNeedsUpdateConstraints()
        self.updateFocusIfNeeded()
        let bounds = CGRect.init(origin: CGPoint.zero, size: size)
        self.bounds = bounds
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return ceil(size.width) + 1.0
        
    }
    
    func autosize_calculateHeightOfCellWithSize(size:CGSize) -> CGFloat {
        var size = size
        self.setNeedsUpdateConstraints()
        self.updateFocusIfNeeded()
        let bounds = CGRect.init(origin: CGPoint.zero, size: size)
        self.bounds = bounds
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        if self.responds(to: #selector(UIView.systemLayoutSizeFitting(_:withHorizontalFittingPriority:verticalFittingPriority:))) {
            size = self.systemLayoutSizeFitting(size, withHorizontalFittingPriority:UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityFittingSizeLevel)
        }
        else{
            size = self.systemLayoutSizeFitting(size)
        }
        return ceil(size.height) + 1.0
    }
    
    func autosize_layoutSubviews() {
        
    }
    
    func updateMetricConstraints() {
        if _metricCell! || (_metricConstraints != nil) {
            return
        }
        
        for constraint:NSLayoutConstraint in _metricConstraints! {
            self.removeConstraint(constraint)
        }
        
        _metricConstraints = nil
    }
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
  
}

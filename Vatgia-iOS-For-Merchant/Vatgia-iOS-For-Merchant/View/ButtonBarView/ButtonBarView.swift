//
//  ButtonBarView.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 12/23/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit

@objc protocol ButtonBarViewDelegate{
    @objc optional func buttonBarCell(cell:ButtonBarCollectionViewCell, _didSelectIndex:NSInteger)
}

class ButtonBarView: UIView {
    
    weak var delegate : ButtonBarViewDelegate?
    var type : ButtonBarType?

    // MARK: - constructor
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
//    override init(frame:CGRect) {
//        super.init(frame:frame)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        
    }
    // MARK: - public instance methods
    
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
    
}

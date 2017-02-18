//
//  MYCollectionExtendView.swift
//  SmartCloud
//
//  Created by 朱益锋 on 2017/2/17.
//  Copyright © 2017年 SmartPower. All rights reserved.
//

import UIKit

class MYCollectionExtendView: UIView {

    var headerHeight:CGFloat{
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var footerHeight:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var scrollView: UIScrollView!
    
    var scrollViewOriginalInset: UIEdgeInsets!
    
    init() {
        super.init(frame: CGRect.zero)
        self.prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        self.autoresizingMask = .flexibleWidth
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeSubviews()
    }
    
    func placeSubviews() {
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let superview = newSuperview else {
            return
        }
        
        if !superview.isKind(of: UIScrollView.self) {
            return
        }
        
        self.frame.size.width = superview.frame.size.width
        
        self.frame.origin.x = 0
        
        self.scrollView = superview as! UIScrollView
        
        self.scrollView.alwaysBounceVertical = true
        
        self.scrollViewOriginalInset = self.scrollView.contentInset
    }

}

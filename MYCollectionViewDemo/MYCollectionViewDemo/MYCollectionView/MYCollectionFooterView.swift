//
//  MYCollectionFooterView.swift
//  SmartCloud
//
//  Created by 朱益锋 on 2017/2/18.
//  Copyright © 2017年 SmartPower. All rights reserved.
//

import UIKit

class MYCollectionFooterView: MYCollectionExtendView {
    
    init(height: CGFloat) {
        super.init()
        self.footerHeight = height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.scrollView.contentInset.bottom = self.frame.size.height + self.scrollViewOriginalInset.bottom
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.frame.origin.x = -self.scrollView.contentInset.left
        self.frame.origin.y = self.scrollView.contentSize.height
    }

}

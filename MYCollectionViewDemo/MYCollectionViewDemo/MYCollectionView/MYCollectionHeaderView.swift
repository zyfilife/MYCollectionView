//
//  MYCollectionHeaderView.swift
//  SmartCloud
//
//  Created by 朱益锋 on 2017/2/17.
//  Copyright © 2017年 SmartPower. All rights reserved.
//

import UIKit

class MYCollectionHeaderView: MYCollectionExtendView {
    
    init(height: CGFloat) {
        super.init()
        self.headerHeight = height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.scrollView.contentInset.top = self.frame.size.height + self.scrollViewOriginalInset.top
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.frame.origin.x = -self.scrollView.contentInset.left
        self.frame.origin.y = -self.scrollView.contentInset.top
    }

}

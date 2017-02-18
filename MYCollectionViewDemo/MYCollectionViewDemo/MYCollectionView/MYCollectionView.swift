//
//  MYCollectionView.swift
//  MYCollectionViewDemo
//
//  Created by 朱益锋 on 2017/2/12.
//  Copyright © 2017年 朱益锋. All rights reserved.
//

import UIKit

@objc protocol MYCollectionViewDataSource: NSObjectProtocol {
    @objc optional func numberOfSections(in my_collection: MYCollectionView) -> Int
    func collectionView(my_collectionView: MYCollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(my_collectionView: MYCollectionView, cellForItemAt indexPath: IndexPath) -> MYCollectionViewCell
}

@objc protocol MYCollectionViewDelegate: UIScrollViewDelegate {
    @objc optional func collectionView(my_collectionView: MYCollectionView, didSelectItemAt indexPath: IndexPath)
    @objc optional func collectionView(my_collectionView: MYCollectionView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForHeaderInSection section: Int) -> UIColor
    @objc optional func collectionView(my_collectionView: MYCollectionView, heightForHeaderInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, viewForFooterInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForFooterInSection section: Int) -> UIColor
    @objc optional func collectionView(my_collectionView: MYCollectionView, heightForFooterInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, containViewInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForContainViewInSection section: Int) -> UIColor
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundViewInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForBackgroundViewInSection section: Int) -> UIColor
}

@objc protocol MYCollectionViewDelegateFlowLayout: MYCollectionViewDelegate {
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, sectionSpacingForSectionAt section: Int) -> CGFloat
}

typealias Section = Int
typealias Row = Int

class MYCollectionView: UIScrollView {
    
    weak var my_dataSource: MYCollectionViewDataSource?
    weak var my_delegate: MYCollectionViewDelegateFlowLayout?
    
    fileprivate var contentViewSize: CGSize {
        return CGSize(width: self.frame.size.width-self.contentInset.left-self.contentInset.right,
                      height: self.frame.size.height-self.contentInset.top-self.contentInset.bottom)
    }
    
    fileprivate var contentHeight:CGFloat = 0.0
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            return
        }
        self.my_reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    deinit {
        print("\(self.classForCoder): 已销毁")
    }
    
    func my_reloadData() {
        
        for view in self.subviews {
            if !view.isKind(of: MYCollectionExtendView.classForCoder()) && !view.isKind(of: MJRefreshComponent.classForCoder()) {
                view.removeFromSuperview()
                for subview in view.subviews {
                    subview.removeFromSuperview()
                    for ssubview in subview.subviews {
                        ssubview.removeFromSuperview()
                    }
                }
            }
        }
        
        guard let delegate = self.my_delegate, let dataSource = self.my_dataSource else {
            return
        }
        
        var sections = 1
        if let number = dataSource.numberOfSections?(in: self) {
            sections = number
        }
        
        var sectionY: CGFloat = 0
        var sectionH: CGFloat = 0
        
        for i in 0..<sections {
            var containView = delegate.collectionView?(my_collectionView: self,
                                                       containViewInSection: i)
            if containView == nil {
                containView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self,
                                                                  backgroundColorForContainViewInSection: i) {
                    containView?.backgroundColor = backgroundColor
                }else {
                    containView?.backgroundColor = .clear
                }
            }
            
            var backgroundView = delegate.collectionView?(my_collectionView: self,
                                                          backgroundViewInSection: i)
            if backgroundView == nil {
                backgroundView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self,
                                                                  backgroundColorForBackgroundViewInSection: i) {
                    backgroundView?.backgroundColor = backgroundColor
                }else {
                    backgroundView?.backgroundColor = .clear
                }
            }
            
            var headerView = delegate.collectionView?(my_collectionView: self,
                                                      viewForHeaderInSection: i)
            if headerView == nil {
                headerView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self,
                                                                  backgroundColorForHeaderInSection: i) {
                    headerView?.backgroundColor = backgroundColor
                }else {
                    headerView?.backgroundColor = .lightGray
                }
            }
            
            var heightForHeader:CGFloat = 0.0
            if let _heightForHeader = delegate.collectionView?(my_collectionView: self,
                                                               heightForHeaderInSection: i) {
                heightForHeader = _heightForHeader
            }
            
            var footerView = delegate.collectionView?(my_collectionView: self,
                                                      viewForFooterInSection: i)
            if footerView == nil {
                footerView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self,
                                                                  backgroundColorForFooterInSection: i) {
                    footerView?.backgroundColor = backgroundColor
                }else {
                    footerView?.backgroundColor = .lightGray
                }
            }
            
            var heightForFooter:CGFloat = 0.0
            if let _heightForFooter = delegate.collectionView?(my_collectionView: self,
                                                               heightForFooterInSection: i) {
                heightForFooter = _heightForFooter
            }
            
            let layout = MYCollectionViewFlowLayout()
            
            var inSets = UIEdgeInsets.zero
            if let _inSets = delegate.collectionView?(my_collectionView: self,
                                                      layout: layout,
                                                      insetForSectionAt: i) {
                inSets = _inSets
            }
            layout.sectionInset = inSets
            
            var minimumInteritemSpacing: CGFloat = 10
            if let _minimumInteritemSpacing = delegate.collectionView?(my_collectionView: self,
                                                                       layout: layout,
                                                                       minimumInteritemSpacingForSectionAt: i) {
                minimumInteritemSpacing = _minimumInteritemSpacing
            }
            layout.minimumInteritemSpacing = minimumInteritemSpacing
            
            var minimumLineSpacing: CGFloat = 10
            if let _minimumLineSpacing = delegate.collectionView?(my_collectionView: self,
                                                                  layout: layout,
                                                                  minimumLineSpacingForSectionAt: i) {
                minimumLineSpacing = _minimumLineSpacing
            }
            layout.minimumLineSpacing = minimumLineSpacing
            
            var sectionSpacing: CGFloat = 0.0
            if let _sectionSpacing = delegate.collectionView?(my_collectionView: self,
                                                              layout: layout,
                                                              sectionSpacingForSectionAt: i) {
                sectionSpacing = _sectionSpacing
            }
            layout.sectionSpacing = sectionSpacing
            
            sectionY += i == 0 ? sectionSpacing + heightForHeader + inSets.top + sectionH: sectionSpacing + heightForHeader + sectionH + inSets.bottom + heightForFooter
            
            let sectionAvailableWidth = self.contentViewSize.width - inSets.left - inSets.right
            layout.sectionAvailableWidth = sectionAvailableWidth
            
            let rows = dataSource.collectionView(my_collectionView: self,
                                                 numberOfItemsInSection: i)
            
            for j in 0..<rows {
                let indexPath = IndexPath(row: j, section: i)
                let cell = dataSource.collectionView(my_collectionView: self,
                                                     cellForItemAt: indexPath)
                var size: CGSize!
                if let _size = delegate.collectionView?(my_collectionView: self,
                                                        layout: layout,
                                                        sizeForItemAt: indexPath) {
                    size = _size
                }else {
                    size = CGSize(width: 50, height: 50)
                }
                layout.itemSize = size
                let columnNumberInALine = Int(Float(sectionAvailableWidth + minimumInteritemSpacing) / Float(size.width + minimumInteritemSpacing))
                let itemSpacing = columnNumberInALine > 1 ? (sectionAvailableWidth - CGFloat(columnNumberInALine)*size.width)/CGFloat(columnNumberInALine-1) : 0
                let row = CGFloat(j / columnNumberInALine)
                let column = CGFloat(j % columnNumberInALine)
                let cellX = inSets.left + size.width*column + itemSpacing*column
                let cellY = inSets.top + size.height*row + minimumLineSpacing*row
                let origin = CGPoint(x: cellX, y: cellY)
                cell.frame = CGRect(origin: origin, size: size)
                cell.indexPath = indexPath
                
                if j == rows-1 {
                    sectionH = cell.frame.maxY
                }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(MYCollectionView.clickCellAction(_:)))
                cell.addGestureRecognizer(tap)
                
                containView?.addSubview(cell)
                
            }
            
            containView?.frame = CGRect(x: 0, y: heightForHeader, width: self.contentViewSize.width, height: sectionH + inSets.bottom)
            
            headerView?.frame = CGRect(x: 0, y: 0, width: self.contentViewSize.width, height: heightForHeader)
            footerView?.frame = CGRect(x: 0, y: containView!.frame.maxY, width: self.contentViewSize.width, height: heightForFooter)
            
            if heightForHeader > 0.5 {
                let lineView = UIView(frame: CGRect(x: 0, y: heightForHeader-0.5, width: self.contentViewSize.width, height: 0.5))
                lineView.backgroundColor = kSeparatorColor
                headerView?.addSubview(lineView)
            }
            
            if heightForFooter > 0.5 {
                let line2 = UIView(frame: CGRect(x: 0, y: 0, width: self.contentViewSize.width, height: 0.5))
                line2.backgroundColor = kSeparatorColor
                footerView?.addSubview(line2)
            }
            
            backgroundView?.addSubview(headerView!)
            backgroundView?.addSubview(containView!)
            backgroundView?.addSubview(footerView!)
            
            backgroundView?.frame = CGRect(x: 0, y: sectionY-inSets.top-heightForHeader, width: self.contentViewSize.width, height: heightForHeader + sectionH + inSets.bottom + heightForFooter)
            
            self.addSubview(backgroundView!)
            
            self.contentHeight = backgroundView!.frame.maxY + sectionSpacing
            
            self.contentSize = CGSize(width: self.contentViewSize.width, height: self.contentHeight)
        }
        self.my_collectionFooterView?.setNeedsLayout()
        self.my_collectionHeaderView?.setNeedsLayout()
    }
    
    @objc fileprivate func clickCellAction(_ tap: UITapGestureRecognizer) {
        if let view = tap.view as? MYCollectionViewCell {
            guard let indexPath = view.indexPath else {
                return
            }
            self.my_delegate?.collectionView?(my_collectionView: self, didSelectItemAt: indexPath)
        }
    }
    
    fileprivate func isInScreen(backgroundView: UIView) -> Bool {
        let viewOriginY = backgroundView.frame.origin.y
        let viewMaxY = backgroundView.frame.origin.y
        return viewMaxY > self.contentOffset.y && viewOriginY < self.bounds.size.height + self.contentOffset.y
    }
    
    fileprivate func isInScreen(containView: UIView) -> Bool {
        guard let backgroundView = containView.superview else {
            return false
        }
        let viewOriginY = containView.frame.origin.y + backgroundView.frame.origin.y
        let viewMaxY = containView.frame.origin.y + backgroundView.frame.origin.y
        return viewMaxY > self.contentOffset.y && viewOriginY < self.bounds.size.height + self.contentOffset.y
    }
    
    fileprivate func isInScreen(cell: UIView) -> Bool {
        guard let containView = cell.superview else {
            return false
        }
        guard let backgroundView = containView.superview else {
            return false
        }
        let viewOriginY = cell.frame.origin.y + containView.frame.origin.y + backgroundView.frame.origin.y
        let viewMaxY = cell.frame.maxY + containView.frame.origin.y + backgroundView.frame.origin.y
        return viewMaxY > self.contentOffset.y && viewOriginY < self.bounds.size.height + self.contentOffset.y
    }
}




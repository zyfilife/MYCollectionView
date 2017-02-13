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
    func collectionView(my_collectionView: MYCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

@objc protocol MYCollectionViewDelegate: UIScrollViewDelegate {
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    @objc optional func collectionView(my_collectionView: MYCollectionView, didSelectItemAt indexPath: IndexPath)
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForHeaderInSection section: Int) -> UIColor
    @objc optional func collectionView(my_collectionView: MYCollectionView, heightForHeaderInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, viewForFooterInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForFooterInSection section: Int) -> UIColor
    @objc optional func collectionView(my_collectionView: MYCollectionView, heightForFooterInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, containViewInSection section: Int) -> UIView?
    @objc optional func collectionView(my_collectionView: MYCollectionView, backgroundColorForContainViewInSection section: Int) -> UIColor
    
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
}

class MYCollectionView: UIScrollView {
    
//    lazy fileprivate var indexPathsOfVisibleItems = [IndexPath]()
//    lazy fileprivate var visibleCells = [UICollectionViewCell]()
//    lazy fileprivate var arrayOfCollectionViewSectionHeaderViews = [UIView]()
//    lazy fileprivate var arrayOfCollectionViewSectionBackgroundViews = [UIView]()
    
    weak var my_dataSource: MYCollectionViewDataSource?
    weak var my_delegate: MYCollectionViewDelegate?
    
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
    
    func my_reloadData() {
        
        self.removeAllSubviews()
        
        guard let delegate = self.my_delegate, let dataSource = self.my_dataSource else {
            return
        }
        
        var sections: Int!
        if let number = dataSource.numberOfSections?(in: self) {
            sections = number
        }else {
            sections = 1
        }
        
        var sectionY: CGFloat = 0
        var sectionW: CGFloat = 0
        var sectionH: CGFloat = 0
        for i in 0..<sections {
            var containView: UIView!
            if let _containView = delegate.collectionView?(my_collectionView: self, containViewInSection: i) {
                containView = _containView
            }else {
                containView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self, backgroundColorForContainViewInSection: i) {
                    containView.backgroundColor = backgroundColor
                }else {
                    containView.backgroundColor = .clear
                }
            }
            
            var headerView: UIView!
            if let _headerView = delegate.collectionView?(my_collectionView: self, viewForHeaderInSection: i) {
                headerView = _headerView
            }else {
                headerView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self, backgroundColorForHeaderInSection: i) {
                    headerView.backgroundColor = backgroundColor
                }else {
                    headerView.backgroundColor = .lightGray
                }
            }
            
            var heightForHeader:CGFloat = 0.0
            if let _heightForHeader = delegate.collectionView?(my_collectionView: self, heightForHeaderInSection: i) {
                heightForHeader = _heightForHeader
            }
            
            var footerView: UIView!
            if let _footerView = delegate.collectionView?(my_collectionView: self, viewForFooterInSection: i) {
                footerView = _footerView
            }else {
                footerView = UIView()
                if let backgroundColor = delegate.collectionView?(my_collectionView: self, backgroundColorForFooterInSection: i) {
                    footerView.backgroundColor = backgroundColor
                }else {
                    footerView.backgroundColor = .lightGray
                }
            }
            
            var heightForFooter:CGFloat = 0.0
            if let _heightForFooter = delegate.collectionView?(my_collectionView: self, heightForFooterInSection: i) {
                heightForFooter = _heightForFooter
            }
            
            let rows = dataSource.collectionView(my_collectionView: self, numberOfItemsInSection: i)
            
            let layout = UICollectionViewFlowLayout()
            
            var inSets: UIEdgeInsets!
            if let _inSets = delegate.collectionView?(my_collectionView: self, layout: layout, insetForSectionAt: i) {
                inSets = _inSets
            }else {
                inSets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            layout.sectionInset = inSets
            var minimumInteritemSpacing: CGFloat = 10
            if let _minimumInteritemSpacing = delegate.collectionView?(my_collectionView: self, layout: layout, minimumInteritemSpacingForSectionAt: i) {
                minimumInteritemSpacing = _minimumInteritemSpacing
            }
            layout.minimumInteritemSpacing = minimumInteritemSpacing
            var minimumLineSpacing: CGFloat = 10
            if let _minimumLineSpacing = delegate.collectionView?(my_collectionView: self, layout: layout, minimumLineSpacingForSectionAt: i) {
                minimumLineSpacing = _minimumLineSpacing
            }
            layout.minimumLineSpacing = minimumLineSpacing
            sectionY += i == 0 ? heightForHeader + inSets.top + sectionH: heightForHeader + sectionH + inSets.bottom + heightForFooter
            sectionW = self.frame.size.width - inSets.left - inSets.right
            
            for j in 0..<rows {
                let indexPath = IndexPath(row: j, section: i)
                let cell = dataSource.collectionView(my_collectionView: self, cellForItemAt: indexPath)
                var size: CGSize!
                if let _size = delegate.collectionView?(my_collectionView: self, layout: layout, sizeForItemAt: indexPath) {
                    size = _size
                }else {
                    size = CGSize(width: 50, height: 50)
                }
                layout.itemSize = size
                let columnNumberInALine = Int(Float(sectionW + minimumInteritemSpacing) / Float(size.width + minimumInteritemSpacing))
                let itemSpacing = columnNumberInALine > 1 ? (sectionW - CGFloat(columnNumberInALine)*size.width)/CGFloat(columnNumberInALine-1) : 0
                let row = CGFloat(j / columnNumberInALine)
                let column = CGFloat(j % columnNumberInALine)
                let cellX = inSets.left + size.width*column + itemSpacing*column
                let cellY = inSets.top + size.height*row + minimumLineSpacing*row
                let origin = CGPoint(x: cellX, y: cellY)
                cell.frame = CGRect(origin: origin, size: size)
                containView.addSubview(cell)
                
                if j == rows-1 {
                    sectionH = cell.frame.maxY
                }
            }
            containView.frame = CGRect(x: 0, y: sectionY-inSets.top, width: self.frame.size.width, height: sectionH + inSets.bottom)
            headerView.frame = CGRect(x: 0, y: sectionY-inSets.top-heightForHeader, width: self.frame.size.width, height: heightForHeader)
            footerView.frame = CGRect(x: 0, y: containView.frame.maxY, width: self.frame.size.width, height: heightForFooter)
            self.addSubview(containView)
            self.addSubview(headerView)
            self.addSubview(footerView)
            self.contentSize = CGSize(width: self.frame.size.width, height: footerView.frame.maxY)
        }
    }
    
    fileprivate func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

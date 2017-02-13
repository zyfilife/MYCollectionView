//
//  ViewController.swift
//  MYCollectionViewDemo
//
//  Created by 朱益锋 on 2017/2/10.
//  Copyright © 2017年 朱益锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MYCollectionViewDelegateFlowLayout, MYCollectionViewDataSource {

    lazy var collectionView: MYCollectionView = {
        let view = MYCollectionView()
        view.my_delegate = self
        view.my_dataSource = self
        view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.frame = self.view.bounds
        view.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 237/255, alpha: 1)
        return view
    }()
    
    var array1 = [1,2,3,4]
    
    var array2 = [1,2,3,4,5,6]
    
    var array3 = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        headerView.backgroundColor = .darkGray
        self.collectionView.collectionHeaderView = headerView
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        footer.backgroundColor = .darkGray
        self.collectionView.collectionFooterView = footer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in my_collection: MYCollectionView) -> Int {
        return 3
    }
    
    func collectionView(my_collectionView: MYCollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.array1.count
        case 1:
            return self.array2.count
        default:
            return self.array3.count
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumInteritemSpacing = collectionViewLayout.minimumInteritemSpacing
        let sectionAvailableWidth = collectionViewLayout.sectionAvailableWidth
        switch indexPath.section {
        case 0:
            let columnNumber = 4
            let width = (sectionAvailableWidth-minimumInteritemSpacing*CGFloat(columnNumber-1))/CGFloat(columnNumber)
            return CGSize(width: width, height: width+25)
        case 1:
            let columnNumber = 2
            let width = (sectionAvailableWidth-minimumInteritemSpacing*CGFloat(columnNumber-1))/CGFloat(columnNumber)
            return CGSize(width: width, height: 45)
        default:
            let columnNumber = 3
            let width = (sectionAvailableWidth-minimumInteritemSpacing*CGFloat(columnNumber-1))/CGFloat(columnNumber)
            return CGSize(width: width, height: width+30)
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        case 1:
            return 10
        default:
            return 20
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        case 1:
            return 9
        default:
            return 53
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        case 1:
            return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        default:
            return UIEdgeInsets(top: 20, left: 36, bottom: 20, right: 36)
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, backgroundColorForContainViewInSection section: Int) -> UIColor {
        return .white
    }
    
    func collectionView(my_collectionView: MYCollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func collectionView(my_collectionView: MYCollectionView, backgroundColorForHeaderInSection section: Int) -> UIColor {
        return UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
    }
    
    func collectionView(my_collectionView: MYCollectionView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(my_collectionView: MYCollectionView, backgroundColorForFooterInSection section: Int) -> UIColor {
        return UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: MYCollectionViewFlowLayout, sectionSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(my_collectionView: MYCollectionView, backgroundViewInSection section: Int) -> UIView? {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        return view
    }
    
}


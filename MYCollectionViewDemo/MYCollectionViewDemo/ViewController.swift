//
//  ViewController.swift
//  MYCollectionViewDemo
//
//  Created by 朱益锋 on 2017/2/10.
//  Copyright © 2017年 朱益锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MYCollectionViewDelegate, MYCollectionViewDataSource {

    lazy var collectionView: MYCollectionView = {
        let view = MYCollectionView()
        view.my_delegate = self
        view.my_dataSource = self
        view.frame = self.view.bounds
        return view
    }()
    
    var array1 = [1,2,3,4]
    
    var array2 = [1,2,3,4,5,6]
    
    var array3 = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        self.view.addSubview(self.collectionView)
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
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumInteritemSpacing = collectionViewLayout.minimumInteritemSpacing
        let inSets = collectionViewLayout.sectionInset
        switch indexPath.section {
        case 0:
            let width = (my_collectionView.frame.size.width-inSets.left-inSets.right-minimumInteritemSpacing*3)/4
            return CGSize(width: width, height: width)
        case 1:
            let width = (my_collectionView.frame.size.width-inSets.left-inSets.right-minimumInteritemSpacing*1)/2
            return CGSize(width: width, height: 45)
        default:
            let width = (my_collectionView.frame.size.width-inSets.left-inSets.right-minimumInteritemSpacing*2)/3.0
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        case 1:
            return 10
        default:
            return 20
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        case 1:
            return 9
        default:
            return 53.0
        }
    }
    
    func collectionView(my_collectionView: MYCollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
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
        return .blue
    }
    
    func collectionView(my_collectionView: MYCollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
}


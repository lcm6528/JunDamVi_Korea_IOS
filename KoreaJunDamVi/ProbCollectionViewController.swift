//
//  ProbCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD

protocol ProbCollectionViewDelegate{
    func ProbCollectionViewSelectedRow(pageindex pIdx: Int, atIndex index: Int)
}
class ProbCollectionViewController: JDVViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataArray:[String] = []
    var delegate:ProbCollectionViewDelegate?
    
    var parentVC:ProbMenuViewController!
    var pageIndex: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ProbCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProbCollectionViewCell
        if pageIndex == 0 {
            
            let title = NSMutableAttributedString(string: "\(dataArray[indexPath.row])회")
            title.addAttributes([NSAttributedString.Key.font : UIFont(name: "NanumBarunGothic", size: 30)! ], range: NSRange(location: 0,length: 2))
            title.addAttributes([NSAttributedString.Key.font : UIFont(name: "NanumBarunGothic", size: 18)! ], range: NSRange(location: 2,length: 1))
            
            let cachedData = JDVDataManager.getSelection(key: dataArray[indexPath.row])
            cell.contentLabel.attributedText = title
            cell.configure(by: cachedData)
        } else {
            let cachedData = JDVDataManager.getSelection(key: dataArray[indexPath.row])
            cell.contentLabel.text = dataArray[indexPath.row]
            cell.configure(by: cachedData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.size.width
        if width > 430 {
            return CGSize(width: 120, height: 120)
        } else {
            let length = width / 3 - 20
            return CGSize(width: length, height: length)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.ProbCollectionViewSelectedRow(pageindex: pageIndex, atIndex: indexPath.row)
    }
    
    //CollectionView cell Highlight Indicate
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.bgWhite
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.bgWhite
    }
}

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
  func ProbCollectionViewSelectedRow(atIndex index:Int)
}
class ProbCollectionViewController: JDVViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

  
    var dataArray:[String] = []
  var delegate:ProbCollectionViewDelegate?
  
  var parentVC:ProbMenuViewController!
  var pageIndex:Int!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArray.count
    }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProbCollectionViewCell
    if pageIndex == 0 {
        
        let title = NSMutableAttributedString(string: "\(dataArray[indexPath.row])회")
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 30)! ], range: NSRange(location: 0,length: 2))
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 18)! ], range: NSRange(location: 2,length: 1))

        cell.contentLabel.attributedText = title
    }else{
    cell.contentLabel.text = dataArray[indexPath.row]
    }
    
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if SCREEN_WIDTH > 430{
      return CGSize(width: 120, height: 120)
    }else{
      let length = SCREEN_WIDTH/3 - 20
      return CGSize(width: length, height: length)
    }
    
   
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    if indexPath.row != 1, indexPath.row != 2{//test code
    WSProgressHUD.show(withStatus: "문제 불러오는 중..")
    isBlockUserInteract = true
    }
    self.delegate?.ProbCollectionViewSelectedRow(atIndex: indexPath.row)
  }

  
  
  //CollectionView cell Highlight Indicate
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = UIColor.lightGray
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = UIColor.white
    
  }
  
}

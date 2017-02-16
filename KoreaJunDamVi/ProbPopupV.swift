//
//  ProbPopupView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 12..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbPopupView: UIViewController {

  
  var dataArray = [String:String]()
  var didSelectHandler: ((Int) -> Void)?
  @IBOutlet var collectionView: UICollectionView!
  
  @IBOutlet var dismissButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      
      
      if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH)/5, height: (SCREEN_WIDTH)/5)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        
        
      }
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  @IBAction func dismissButtonAction(_ sender: AnyObject) {
    
    dismiss(animated: true, completion: nil)
  }
}


extension ProbPopupView:UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    self.didSelectHandler?(indexPath.row)
    dismiss(animated: true, completion: nil)
  }
  
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    
//    let size =  CGSize(width: (SCREEN_WIDTH)/5, height: (SCREEN_WIDTH)/5)
//    return size
//    
//  }
//  
//  
//  func collectionView(collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//    return 0.0
//  }
}

extension ProbPopupView:UICollectionViewDataSource{
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return dataArray.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
    
  }
  
}

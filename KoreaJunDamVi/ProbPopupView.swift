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
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}


extension ProbPopupView:UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    self.didSelectHandler?(indexPath.row)
    dismiss(animated: true, completion: nil)
  }
  
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

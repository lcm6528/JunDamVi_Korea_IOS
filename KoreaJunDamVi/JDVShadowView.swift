
//
//  JDVShadowView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 20..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVShadowView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
    */
  override func draw(_ rect: CGRect) {
    
    let path = UIBezierPath(rect: rect)
    
    self.layer.shadowRadius = 0.5
    self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowPath = path.cgPath
    self.layer.shadowOpacity = 0.5
  
  }

}

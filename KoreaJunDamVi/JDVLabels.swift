//
//  JDVLabel.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 17..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

class JDVLabel: UILabel {


  
  override func drawText(in rect: CGRect) {
    let inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    super.drawText(in: rect.inset(by: inset))
  }
}


class JDVLabelWithTBLine: UILabel {
  
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect)
    let topLine = CALayer()
    topLine.borderColor = UIColor.black.cgColor
    topLine.borderWidth = 0.5
    topLine.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: 0.5)
    self.layer.addSublayer(topLine)
    
    let botLine = CALayer()
    botLine.borderColor = UIColor.black.cgColor
    botLine.borderWidth = 0.5
    botLine.frame = CGRect(x: 0, y: rect.size.height-1, width: rect.size.width, height: 0.5)
    self.layer.addSublayer(botLine)
    
  }
}

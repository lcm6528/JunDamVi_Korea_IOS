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
    super.drawText(in: UIEdgeInsetsInsetRect(rect, inset))
  }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

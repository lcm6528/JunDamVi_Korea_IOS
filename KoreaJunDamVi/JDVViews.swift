//
//  JDVViewWithBotLine.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 1..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVViewWithBotLine: UIView {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.clipsToBounds = false
    
    let botLine = UIView(frame: CGRect(x: 0, y: rect.height-0.3, width: rect.width, height: 0.3))
    botLine.backgroundColor = UIColor.lightGray
    self.addSubview(botLine)
    
  }
  
}

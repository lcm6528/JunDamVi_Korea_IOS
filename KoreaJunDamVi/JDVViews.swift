//
//  JDVViewWithBotLine.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 1..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVViewWithBotLine: UIView , Markable{
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    let botLine = UIView(frame: CGRect(x: 0, y: rect.height-0.3, width: rect.width, height: 0.3))
    botLine.backgroundColor = UIColor.lightGray
    self.addSubview(botLine)
    
  }
  
}

protocol Markable{
    func mark()
}

extension Markable where Self:UIView{
    
    func mark(){
        let superFrame = self.frame
        let label = UILabel(x: superFrame.w - 29, y: 7, w: 24, h: 20, fontSize: 10)

        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "정답"
        label.layer.cornerRadius = 3
        label.backgroundColor = UIColor.noteMarkBlud
        label.textColor = UIColor.white
        label.font =  UIFont(name: "NanumBarunGothic", size: 10)!
        

        addSubview(label)
        
    }
    
}

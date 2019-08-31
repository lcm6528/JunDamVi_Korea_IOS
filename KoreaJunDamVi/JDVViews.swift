//
//  JDVViewWithBotLine.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 1..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVViewWithBotLine: UIView {
    var marker: UILabel = UILabel(frame: CGRect(x: SCREEN_WIDTH - 53, y: 7, width: 24, height: 20 ))
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let botLine = UIView(frame: CGRect(x: 0, y: rect.height - 0.3, width: rect.width, height: 0.3))
        botLine.backgroundColor = UIColor.lightGray
        
        marker.clipsToBounds = true
        marker.textAlignment = .center
        marker.text = "정답"
        marker.layer.cornerRadius = 3
        marker.backgroundColor = UIColor.noteMarkBlud
        marker.textColor = UIColor.white
        marker.font =  UIFont(name: "NanumBarunGothic", size: 10)!
//        marker.isHidden = true
        
        self.addSubview(botLine)
        
    }
    
    func showMark() {
        marker.removeFromSuperview()
        self.addSubview(marker)
    }
    
    func hideMark() {
        marker.removeFromSuperview()
    }
}

protocol Markable{
    func mark()
}

extension Markable where Self: UIView {
    func mark() {
        let label = UILabel(frame: CGRect(x: SCREEN_WIDTH - 53, y: 7, width: 24, height: 20 ))
        
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

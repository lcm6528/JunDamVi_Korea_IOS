//
//  JDVButton.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 12. 15..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            refreshUI()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    func refreshUI() {
        
    }
}

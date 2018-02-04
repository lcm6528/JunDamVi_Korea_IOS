//
//  JDVButton.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 12. 15..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class JDVButton: UIButton {
    
    private var buttonScales:Dictionary = [UInt: CGFloat]()
    
    @IBInspectable var bounceWithInteraction:Bool = false
    
    override var isHighlighted: Bool {
        didSet {
            changeScaleForStateChange()
        }
    }
    override var isSelected: Bool {
        didSet {
            changeScaleForStateChange()
            
        }
    }
    override var isEnabled: Bool {
        didSet {
            changeScaleForStateChange()
        }
    }
    
    @objc func bounce() {
        guard bounceWithInteraction == false else{ return }
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.buttonScales[UIControlState.normal.rawValue] = 1.0
        self.buttonScales[UIControlState.disabled.rawValue] = 1.0
        self.buttonScales[UIControlState.highlighted.rawValue] = 0.9
        
        self.addTarget(self, action: #selector(JDVButton.bounce), for: .touchUpInside)
        self.layer.masksToBounds = true
    }
    
    private func changeScaleForStateChange() {
        
        guard bounceWithInteraction == true else{ return }
        if let scale = buttonScales[state.rawValue] ?? buttonScales[UIControlState.normal.rawValue] {
            if transform.a != scale && transform.b != scale {
                let animations = {
                    self.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
                UIView.animate(withDuration: 0.1, animations: animations)
            }
        }
    }
    
    
}

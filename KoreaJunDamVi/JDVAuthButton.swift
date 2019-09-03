//
//  File.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 01/09/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import Foundation
import UIKit

class JDVTempleteRoundButton: JDVButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1.5
        refreshUI()
    }
}

class JDVAuthButton: JDVTempleteRoundButton {
    
    private let selectedBlue = UIColor(red: 0/255.0, green: 102/255.0, blue: 255/255.0, alpha: 1)
    var backColor: UIColor {
        return self.isSelected ? UIColor.white : selectedBlue
    }
    var auth: Int = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderColor = selectedBlue.cgColor
        self.setTitleColor(selectedBlue, for: .selected)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle("지금 정답 확인하기", for: .normal)
        self.setTitle("\(auth)번", for: .selected)
        refreshUI()
    }
    
    override func refreshUI() {
        self.backgroundColor = backColor
    }
}

class JDVSolButton: JDVTempleteRoundButton {
    
    private let selectedRed = UIColor(red: 146/255.0, green: 26/255.0, blue: 26/255.0, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderColor = selectedRed.cgColor
    }
}

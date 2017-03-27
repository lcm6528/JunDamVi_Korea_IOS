//
//  JDVColors.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 22..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var untBlack505050: UIColor {
        return UIColor(white: 50.0 / 255.0, alpha: 1.0)
    }
    
    class var untPaleRed: UIColor {
        return UIColor(red: 225.0 / 255.0, green: 64.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }
    class var defaultIvory: UIColor {
        return UIColor(red: 234.0 / 255.0, green: 230.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
    }
    class var untBlack757575: UIColor {
        return UIColor(white: 75.0 / 255.0, alpha: 1.0)
    }
    
    class var selectedRed: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 201.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
    }
    
    class var ProbCompleteRed: UIColor {
        return UIColor(red: 227.0 / 255.0, green: 71.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    }
    
    
    class var themeColor: UIColor {
        return UIColor(red: 146.0 / 255.0, green: 26.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
    }
    
    class var probCellIvory: UIColor {
        return UIColor(red: 202.0 / 255.0, green: 195.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
    }
    
    class var probCellRed: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 81.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }
    
}


class JDVNoteBarButtonItem: UIBarButtonItem{
    
    var isSelected:Bool = false{
        didSet{
            self.image = isSelected ? UIImage(named: "star_selected") : UIImage(named: "star")
        }
    }
    
    
    
}

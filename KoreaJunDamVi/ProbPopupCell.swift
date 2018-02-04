//
//  ProbPopupCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbPopupCell : UICollectionViewCell {
    
    @IBOutlet var label_ProbNum: UILabel!
    @IBOutlet var imgView_Star: UIImageView!
    @IBOutlet var imgView_Check: UIImageView!
    
    
    func configure(WithProb prob:Prob, selections select:Int, isNoted isnoted:Bool) {
        
        imgView_Star.image =  isnoted ? UIImage(named: "small_star_selected") : UIImage(named: "small_star_unselected")
        imgView_Check.image = select == 0 ? UIImage(named: "uncheck") :  UIImage(named: "check")
        self.backgroundColor = select == 0 ? UIColor.white : UIColor.popupCellIvory
        
    }
    
}

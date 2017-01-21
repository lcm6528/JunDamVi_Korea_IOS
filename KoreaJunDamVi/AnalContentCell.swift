//
//  AnalContentCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 19..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class AnalContentCell: UITableViewCell {

  @IBOutlet var bar1: AnalBarChartView!
  @IBOutlet var bar2: AnalBarChartView!
  @IBOutlet var bar3: AnalBarChartView!
  @IBOutlet var bar4: AnalBarChartView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setBarUI(withAnimate animate:Bool){
    
    bar1.setBarUI(withAnimate: animate)
    bar2.setBarUI(withAnimate: animate)
    bar3.setBarUI(withAnimate: animate)
    bar4.setBarUI(withAnimate: animate)
    
  }
  
}

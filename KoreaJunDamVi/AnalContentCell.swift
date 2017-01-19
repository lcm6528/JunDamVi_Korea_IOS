//
//  AnalContentCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 19..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class AnalContentCell: UITableViewCell {

  @IBOutlet var bar: AnalBarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

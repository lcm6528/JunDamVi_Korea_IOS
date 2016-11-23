//
//  SettingsTableViewCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 23..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

  @IBOutlet var contentImageView: UIImageView!
  
  @IBOutlet var contentTitleLabel: UILabel!
  @IBOutlet var contentSubtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

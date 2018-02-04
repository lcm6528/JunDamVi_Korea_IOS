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
    
    func configure(model:SettingsViewCellModel) {
        
        self.contentImageView.image = model.image
        self.contentTitleLabel.text = model.title
        self.contentSubtitleLabel.text = model.desc
        
    }
}

enum SettingsOption{
    
    case reset
    case restore
    case mail
    case none
    
}
struct SettingsViewCellModel{
    
    let image:UIImage
    let title:String
    let desc:String
    var handler:()->()
    
    init(withOption opt:SettingsOption) {
        
        switch opt {
        case .reset:
            self.image = UIImage(named: "reset")!
            self.title = "학습내역 초기화"
            self.desc = "학습내역을 초기화하면 앱 내 모든 정보가 초기화됩니다."
            
        case .restore:
            self.image = UIImage(named: "restore")!
            self.title = "구매내역 복원"
            self.desc = "해설 구매내역을 복원합니다."
        case .mail:
            self.image = UIImage(named: "mail")!
            self.title = "문의 및 제안"
            self.desc = "jundamvi@gmail.com 으로 의견을 보내주세요!"
        case .none:
            self.image = UIImage()
            self.title = ""
            self.desc = ""
        }
        
        handler = {}
        
    }
}

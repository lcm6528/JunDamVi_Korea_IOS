//
//  SettingsTableViewCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 23..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet var contentTitleLabel: UILabel!
    @IBOutlet var contentSubtitleLabel: UILabel!
    
    func configure(model:SettingsViewCellModel) {
        self.contentTitleLabel.text = model.title
        self.contentSubtitleLabel.text = model.desc
    }
}

enum SettingsOption {
    case reset
    case restore
    case mail
    case showprob
    case autonext
    case none
}

struct SettingsViewCellModel {
    
    let title: String
    let desc: String
    
    let option: SettingsOption
    
    init(withOption opt: SettingsOption) {
        self.option = opt
        switch opt {
        case .reset:
            self.title = "학습내역 초기화"
            self.desc = "학습내역을 초기화하면 앱 내 모든 정보가 초기화됩니다."
        case .restore:
            self.title = "구매내역 복원"
            self.desc = "해설 구매내역을 복원합니다."
        case .mail:
            self.title = "문의 및 제안"
            self.desc = "jundamvi@gmail.com 으로 의견을 보내주세요!"
        case .showprob:
            self.title = "선택 후 해설보기"
            self.desc = "정답 선택 시 자동 해설 표시"
        case .autonext:
            self.title = "문제 자동 넘기기"
            self.desc = "정답 선택 시 자동 넘기기"
        default:
            self.title = ""
            self.desc = ""
        }
    }
}

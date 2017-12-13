//
//  ProbCollectionViewCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var bottomView: JDVViewWithBotLine!
    
    override func awakeFromNib() {
        //UI Set
        self.layer.cornerRadius = 5
    }
    
    func configure(by data:[Int]?){
        
        guard let data = data else{
            stateLabel.text = "학습 미완료"
            stateLabel.textColor = UIColor.lightGray
            bottomLabel.text = "- / -"
            return
        }
        
        stateLabel.text = (data.isEmpty) ? "학습 완료" : "학습 진행중"
        stateLabel.textColor = (data.isEmpty) ? UIColor.probCellRed : UIColor.untPaleRed
        bottomLabel.text = (data.isEmpty) ? "" : "\(data.count -  data.filter{$0==0}.count) / \(data.count)"
    }
}

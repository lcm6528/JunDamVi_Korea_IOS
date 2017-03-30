//
//  ProbCollectionViewCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import EZSwiftExtensions
class ProbCollectionViewCell: UICollectionViewCell {
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var bottomView: JDVViewWithBotLine!
    
    func configure(by data:[Int]?){
        
        if data != nil{
            if data!.isEmpty == true{
                stateLabel.text = "학습 완료"
                stateLabel.textColor = UIColor.probCellRed
                bottomLabel.text = ""
                
                
            }else{
                stateLabel.text = "학습 진행중"
                stateLabel.textColor = UIColor.untPaleRed
                if data != nil{
                    bottomLabel.text = "\(data!.count -  data!.indexes(of: 0).count) / \(data!.count)"
                }else{
                    bottomLabel.text = "- / -"
                }
                
            }
        }else{
            stateLabel.text = "학습 미완료"
            stateLabel.textColor = UIColor.lightGray
            bottomLabel.text = "- / -"
            
        }
        
    }
    
}

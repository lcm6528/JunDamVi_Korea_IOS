//
//  SolutionCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 25/08/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import UIKit

class SolutionCell: UITableViewCell, TempleteCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: JDVTextViewPadding!
    
    let titleStrings = ["키워드", "최선의 풀이", "차선의 풀이"]
    
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
        let sol = data.sol
        
        titleLabel.text = titleStrings[idx]
        
        if idx == 0 {
            contentTextView.attributedText = sol.keyword_attString
        } else if idx == 1 {
            contentTextView.attributedText = sol.content1_attString
        } else {
            contentTextView.attributedText = sol.content2_attString
        }
    }
}

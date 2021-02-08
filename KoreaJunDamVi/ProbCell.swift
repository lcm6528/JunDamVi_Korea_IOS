//
//  ProbCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 25/08/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import UIKit


protocol TempleteCell: UITableViewCell {
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION)
}

class ProbCell: UITableViewCell, TempleteCell {
 
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var contentTextView: JDVTextViewPadding!
    
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
        let prob = data.prob
        if option == .CURATED {
            titleTextView.attributedText = prob.title_attString_probId
        } else if option == .NOTE {
            titleTextView.attributedText = prob.title_attString_noNum
        } else {
            titleTextView.attributedText = prob.title_attString
        }
        self.contentTextView.attributedText = prob.article_attString
        self.scoreLabel.text = "[\(prob.Score)점]"
        self.scoreLabel.font = UIFont.scoreFont
    }
}

class ShowAuthCell: UITableViewCell, TempleteCell {
    
    @IBOutlet weak var button: JDVAuthButton!
    
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
        button.auth = data.answer + 1
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

class ShowSolCell: UITableViewCell, TempleteCell {
    
    @IBOutlet weak var button: JDVAuthButton!
    
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
    }
}


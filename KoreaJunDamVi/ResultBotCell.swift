
//
//  ProbResultBotCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 21..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbResultBotCell: UITableViewCell {
    
    @IBOutlet var ProbNumLabel: UILabel!
    @IBOutlet var ScoreLabel: UILabel!
    @IBOutlet var AnswerLabel: UILabel!
    @IBOutlet var SelectionLabel: UILabel!
    @IBOutlet var StateLabel: UILabel!
    @IBOutlet var noteButton: UIButton!
    
    func configure(item:Try) {
        ProbNumLabel.text = "\(item.ProbNum)번"
        ScoreLabel.text = "\(item.Score)점"
        AnswerLabel.text = "\(item.Answer)"
        SelectionLabel.text = "\(item.Selection)"
        StateLabel.text = item.State.rawValue
        StateLabel.textColor = (item.State == .Wrong) ? UIColor.red : UIColor.black
        noteButton.isSelected = JDVNoteManager.isAdded(by: item.ProbID)
    }
    
    func configureForSimpleResult(item:Try) {   
        ProbNumLabel.textAlignment = .left
        
        ProbNumLabel.text = "  \(item.TestNum)회 \(item.ProbNum)번  "
        ScoreLabel.text = "\(item.Score)점"
        AnswerLabel.text = "\(item.Answer)"
        SelectionLabel.text = "\(item.Selection)"
        StateLabel.text = item.State.rawValue
        StateLabel.textColor = (item.State == .Wrong) ? UIColor.red : UIColor.black
        noteButton.isSelected = JDVNoteManager.isAdded(by: item.ProbID)
    }
}

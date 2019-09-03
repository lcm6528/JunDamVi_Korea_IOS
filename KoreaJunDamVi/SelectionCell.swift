//
//  SelectionCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 25/08/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import UIKit

class SelectionCell: UITableViewCell, TempleteCell {

    public enum SELECT_STATE {
        case SELECTED
        case NOTE_SELECTED
        case AUTH
        case NONE
    }
    
    @IBOutlet weak var contentContainerView: JDVViewWithBotLine!
    @IBOutlet weak var contentTextView: UITextView!
    
    func configure(data: ProbData, idx: Int, option: TEMPLETE_OPTION) {
        let prob = data.prob
        contentTextView.attributedText = prob.choices_attString[idx]
    }
    
    func setState(state: SELECT_STATE) {
        
        switch state {
        case .SELECTED:
            contentContainerView.backgroundColor = UIColor.selectedBackgroundRed
            contentContainerView.layer.borderColor = UIColor.selectedBorderRed.cgColor
            contentContainerView.layer.borderWidth = 1
            contentContainerView.layer.cornerRadius = 3
            contentTextView.textColor = UIColor.black
            contentContainerView.hideMark()
            
        case .AUTH:
            contentContainerView.backgroundColor = UIColor.authBackgorundSkyBlue
            contentContainerView.layer.borderColor = UIColor.authborderSkyBlue.cgColor
            contentContainerView.layer.borderWidth = 1
            contentContainerView.layer.cornerRadius = 3
            contentTextView.textColor = UIColor.black
            contentContainerView.showMark()
            
        case .NONE:
            contentContainerView.backgroundColor = UIColor.white
            contentContainerView.layer.borderColor = UIColor.clear.cgColor
            contentContainerView.layer.borderWidth = 0
            contentContainerView.layer.cornerRadius = 0
            contentTextView.textColor = UIColor.black
            contentContainerView.hideMark()
        
        case .NOTE_SELECTED:
            contentContainerView.backgroundColor = UIColor.white
            contentContainerView.layer.borderColor = UIColor.clear.cgColor
            contentContainerView.layer.borderWidth = 0
            contentContainerView.layer.cornerRadius = 0
            contentTextView.textColor = UIColor.red
            contentContainerView.hideMark()
        }
    }
}

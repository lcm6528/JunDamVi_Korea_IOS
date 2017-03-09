//
//  NoteInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 8..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class NoteInnerViewController: JDVViewController {
    
    
    @IBOutlet var textView_sol: UITextView!
    @IBOutlet var label_header: UILabel!
    @IBOutlet var button_Purchase: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    var Prob:Prob!
    var selection:Int!
    
    @IBOutlet var testTitleTextView: UITextView!
    @IBOutlet var testContentTextView: UITextView!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    @IBOutlet var testChoiceViews: [UIView]!
    @IBOutlet var testChoiceTextViews: [UITextView]!
    
    var choiceManager:JDVChoiceViewManager?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setTitleWithStyle("\(Prob.TestNum)회 \(Prob.ProbNum)번")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setStackView()
        choiceManager = JDVChoiceViewManager(WithViews: testChoiceViews[0],testChoiceViews[1],testChoiceViews[2],testChoiceViews[3],testChoiceViews[4])
        
        if selection != 0 { choiceManager?.setColorForStateAtIndex(selection, state: .selected) }
        
        choiceManager?.setColorForStateAtIndex(Prob.Answer-1, state: .auth)
        choiceManager?.isActive = false
        
        configure()
        
    }
    
    
    func configure(){
        
        self.testTitleTextView.attributedText = Prob.title_attString
        self.testContentTextView.attributedText = Prob.article_attString
        self.ScoreLabel.text = "[\(Prob.Score)점]"
        for (index,textView) in testChoiceTextViews.enumerated(){
            textView.attributedText = Prob.choices_attString[index]
        }
        
    }
    
    
    func setStackView(){
//        
//        label_header.removeFromSuperview()
//        textView_sol.removeFromSuperview()
        button_Purchase.removeFromSuperview()
        textView_sol.text = "test123\ntest123\ntest123\ntest123\ntest123\ntest123\n"
        
    }
}

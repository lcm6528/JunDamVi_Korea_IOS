//
//  NoteInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 8..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class NoteInnerViewController: JDVViewController {
    
    
    @IBOutlet var button_Purchase: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    var Prob:Prob!
    var Sol:Solution!
    var selection:Int!
    
    @IBOutlet var testTitleTextView: UITextView!
    @IBOutlet var testContentTextView: UITextView!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    @IBOutlet var testChoiceViews: [JDVViewWithBotLine]!
    @IBOutlet var testChoiceTextViews: [UITextView]!
    
    

    @IBOutlet var Sol_Labels: [UILabel]!
    @IBOutlet var Sol_TextViews: [UITextView]!
    
    
    
    
    var choiceManager:JDVChoiceViewManager?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setTitleWithStyle("\(Prob.TestNum)회 \(Prob.ProbNum)번")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        choiceManager = JDVChoiceViewManager(WithViews: testChoiceViews[0],testChoiceViews[1],testChoiceViews[2],testChoiceViews[3],testChoiceViews[4])
        
        if selection != 0 { choiceManager?.setColorForStateAtIndex(selection-1, state: .selected) }
        
        choiceManager?.setColorForStateAtIndex(Prob.Answer-1, state: .auth)
        testChoiceViews[Prob.Answer-1].mark()
        choiceManager?.isActive = false
        
        
        configure()
        
        
        isHideSolution(bool: true)
        
    }
    
    
    func configure(){
        
        self.testTitleTextView.attributedText = Prob.title_attString
        self.testContentTextView.attributedText = Prob.article_attString
        self.ScoreLabel.text = "[\(Prob.Score)점]"
        for (index,textView) in testChoiceTextViews.enumerated(){
            textView.attributedText = Prob.choices_attString[index]
        }
        
    }
    
    
    @IBAction func purchaseButtonPressed(_ sender: Any) {
        
        isHideSolution(bool: false)
        
    }

    
    func isHideSolution(bool:Bool){
        
        button_Purchase.isHidden = !bool
        
        for label in Sol_Labels{
            label.isHidden = bool
        }
        
        for textView in Sol_TextViews{
            textView.isHidden = bool
        }
        
    }
    
    
    
    
}

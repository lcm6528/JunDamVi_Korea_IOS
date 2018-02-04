//
//  ProbTestInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbTestInnerViewController: JDVViewController,JDVChoiceViewManagerDelegate {
    
    var Prob:Prob!
    
    var pageIndex:Int!
    var selection = 0
    var selectHandler:((Int,Int)->Void)?
    var option:JDVProbManager.SortedOption!
    
    @IBOutlet var testTitleTextView: UITextView!
    @IBOutlet var testContentTextView: UITextView!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    @IBOutlet var testChoiceViews: [UIView]!
    @IBOutlet var testChoiceTextViews: [UITextView]!
    
    var choiceManager:JDVChoiceViewManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choiceManager = JDVChoiceViewManager(WithViews: testChoiceViews[0],testChoiceViews[1],testChoiceViews[2],testChoiceViews[3],testChoiceViews[4])
        choiceManager?.indexOfPage = pageIndex
        choiceManager?.delegate = self
        
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if selection != 0 {
            choiceManager?.setColorForStateAtIndex(selection-1, state: .selected)
        }
    }
    
    func configure() {
        
        if option != .test{
            self.testTitleTextView.attributedText = Prob.title_attString_noNum
        } else {
            self.testTitleTextView.attributedText = Prob.title_attString
        }
        
        self.testContentTextView.attributedText = Prob.article_attString
        
        self.ScoreLabel.text = "[\(Prob.Score)점]"
        for (index,textView) in testChoiceTextViews.enumerated() {
            textView.attributedText = Prob.choices_attString[index]
        }
    }
    
    
    
    func JDVChoiceViewManagerDelegate(_ manager: JDVChoiceViewManager, didSelectedLabelAtIndex index: Int) {
        self.selectHandler?(pageIndex,index+1)
    }
    
}

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
    var Solv:Solution?
    var selection:Int!
    
    @IBOutlet var testTitleTextView: UITextView!
    @IBOutlet var testContentTextView: UITextView!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    @IBOutlet var testChoiceViews: [JDVViewWithBotLine]!
    @IBOutlet var testChoiceTextViews: [UITextView]!
    
    
    @IBOutlet var solKeywordLabel: UILabel!
    @IBOutlet var solTitleLabel: UILabel!
    @IBOutlet var solSubtitleLabel: UILabel!
    
    @IBOutlet var solKeywordTextView: UITextView!
    @IBOutlet var solContentTextView1: UITextView!
    @IBOutlet var solContentTextView2: UITextView!
    
    
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
        
        if Solv == nil{
            Solv = Solution()
        }
        
        configure()
        
        
        isHideSolution(bool: true)
        
    }
    
    
    
    func configure(){
        
        let title = NSMutableAttributedString(string: "최선의 풀이")
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
        solTitleLabel.attributedText = title
        
        
        let subtitle = NSMutableAttributedString(string: "차선의 풀이")
        subtitle.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
        subtitle.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
        solSubtitleLabel.attributedText = subtitle
        
        
        self.testTitleTextView.attributedText = Prob.title_attString
        self.testContentTextView.attributedText = Prob.article_attString
        self.ScoreLabel.text = "[\(Prob.Score)점]"
        for (index,textView) in testChoiceTextViews.enumerated(){
            textView.attributedText = Prob.choices_attString[index]
        }
        
        
        
        self.solKeywordTextView.attributedText = Solv?.keyword_attString
        self.solContentTextView1.attributedText = Solv?.content1_attString
        self.solContentTextView2.attributedText = Solv?.content2_attString
        
    }
    
    
    @IBAction func purchaseButtonPressed(_ sender: Any) {
        
        isHideSolution(bool: false)
        
    }

    
    func isHideSolution(bool:Bool){
        
        button_Purchase.isHidden = !bool
        
        solKeywordLabel.isHidden = bool
        solTitleLabel.isHidden = bool
        solSubtitleLabel.isHidden = bool
        
        solKeywordTextView.isHidden = bool
        solContentTextView1.isHidden = bool
        solContentTextView2.isHidden = bool
        
    }
    
    
    
    
}

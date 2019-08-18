//
//  NoteInnerViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 8..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import Toaster
class NoteInnerViewController: JDVViewController {
    
    @IBOutlet var button_Purchase: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    var noteData: NoteData!
    var pageIndex: Int!
    
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
    
    var isPurchased:Bool = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        choiceManager = JDVChoiceViewManager(WithViews: testChoiceViews[0],testChoiceViews[1],testChoiceViews[2],testChoiceViews[3],testChoiceViews[4])
        
        if noteData.selection != 0 { choiceManager?.setColorForStateAtIndex(noteData.selection-1, state: .selected) }
        
        choiceManager?.setColorForStateAtIndex(noteData.prob.Answer-1, state: .auth)
        testChoiceViews[noteData.prob.Answer-1].mark()
        choiceManager?.isActive = false
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPurchased = JDVProductManager.isPurchased()
        isHideSolution(bool: !isPurchased)
    }
    
    func configure() {
        
        let title = NSMutableAttributedString(string: "최선의 풀이")
        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
        solTitleLabel.attributedText = title
        
        
        let subtitle = NSMutableAttributedString(string: "차선의 풀이")
        subtitle.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
        subtitle.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
        solSubtitleLabel.attributedText = subtitle
        
        
        self.testTitleTextView.attributedText = noteData.prob.title_attString
        self.testContentTextView.attributedText = noteData.prob.article_attString
        self.ScoreLabel.text = "[\(noteData.prob.Score)점]"
        for (index,textView) in testChoiceTextViews.enumerated() {
            textView.attributedText = noteData.prob.choices_attString[index]
        }
        
        self.solKeywordTextView.attributedText = noteData.sol.keyword_attString
        self.solContentTextView1.attributedText = noteData.sol.content1_attString
        self.solContentTextView2.attributedText = noteData.sol.content2_attString
    }
    
    
    @IBAction func purchaseButtonPressed(_ sender: Any) {
        purchase()
    }
    
    func isHideSolution(bool:Bool) {
        
        button_Purchase.isHidden = !bool
        
        solKeywordLabel.isHidden = bool
        solTitleLabel.isHidden = bool
        solSubtitleLabel.isHidden = bool
        
        solKeywordTextView.isHidden = bool
        solContentTextView1.isHidden = bool
        solContentTextView2.isHidden = bool
    }
    
    func purchase() {
        SwiftyStoreKit.purchaseProduct(ProductID, atomically: true) { result in
            switch result {
            case .success:
                Toast(text: "구매 성공!").show()
                setUserDefaultWithBool(true, forKey: ProductID)
                self.isPurchased = true
                self.isHideSolution(bool: !self.isPurchased)
                
                
            case .error:
                Toast(text: "결제 중 오류가 발생했습니다.").show()
                
            }
        }
    }
}

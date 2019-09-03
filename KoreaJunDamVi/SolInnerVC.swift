////
////  JDVSolutionInnerViewController.swift
////  KoreaJunDamVi
////
////  Created by 이창민 on 2017. 1. 11..
////  Copyright © 2017년 JunDamVi. All rights reserved.
////
//
//import UIKit
//
//class JDVSolutionInnerViewController: JDVViewController,JDVChoiceViewManagerDelegate {
//
//    var Prob:ProbData!
//    var Solv:Solution!
//    var pageIndex: Int!
//
//    @IBOutlet var testTitleTextView: UITextView!
//    @IBOutlet var testContentTextView: UITextView!
//    @IBOutlet var testScoreLabel: UILabel!
//
//    @IBOutlet var testChoiceTextViews: [UITextView]!
//    @IBOutlet var testChoiceViews: [JDVViewWithBotLine]!
//
//
//    @IBOutlet var solTitleLabel: UILabel!
//    @IBOutlet var solSubtitleLabel: UILabel!
//
//    @IBOutlet var solKeywordTextView: UITextView!
//    @IBOutlet var solContentTextView1: UITextView!
//    @IBOutlet var solContentTextView2: UITextView!
//
//    var choiceManager:JDVChoiceViewManager?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let title = NSMutableAttributedString(string: "최선의 풀이")
//        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
//        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
//        solTitleLabel.attributedText = title
//
//
//        let subtitle = NSMutableAttributedString(string: "차선의 풀이")
//        subtitle.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 17)! ], range: NSRange(location: 0,length: 2))
//        subtitle.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothicUltraLight", size: 17)! ], range: NSRange(location: 2,length: 4))
//        solSubtitleLabel.attributedText = subtitle
//
//
//
//        choiceManager = JDVChoiceViewManager(WithViews: testChoiceViews[0],testChoiceViews[1],testChoiceViews[2],testChoiceViews[3],testChoiceViews[4])
//        choiceManager?.indexOfPage = pageIndex
//        choiceManager?.delegate = self
//
//
//        choiceManager?.setColorForStateAtIndex(Prob.Answer-1, state: .auth)
//        testChoiceViews[Prob.Answer-1].mark()
//
//        choiceManager?.isActive = false
//
//        configure()
//        // Do any additional setup after loading the view.
//    }
//
//    func configure() {
//
//        self.testTitleTextView.attributedText = Prob.title_attString
//
//        self.testContentTextView.attributedText = Prob.article_attString
//        self.testScoreLabel.text = "[\(Prob.Score)점]"
//        for (index,textView) in testChoiceTextViews.enumerated() {
//            textView.attributedText = Prob.choices_attString[index]
//        }
//
//        self.solKeywordTextView.attributedText = Solv.keyword_attString
//        self.solContentTextView1.attributedText = Solv.content1_attString
//        self.solContentTextView2.attributedText = Solv.content2_attString
//    }
//}
//

//
//  ProbResultTopView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import UICountingLabel


class ProbResultTopView: UIView {
    var view:UIView!
    let NibName:String = "ProbResultTopView"
    
    var delegate:ProbResultSubViewDelegate?
    @IBOutlet var gageView: GageView!
    
    
    @IBOutlet var roundView1: RoundView!
    @IBOutlet var roundView2: RoundView!
    
    @IBOutlet var label_comment: UILabel!
    @IBOutlet var label_grade: UILabel!
    
    @IBOutlet var label_correct: UICountingLabel!
    @IBOutlet var label_wrong: UILabel!
    @IBOutlet var label_Trial: UILabel!
    @IBOutlet var label_Score: UILabel!
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        label_Trial.layer.cornerRadius = 6
        label_Score.layer.cornerRadius = 6
        
        
        
        
        
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func changeView(_ sender: AnyObject) {
        self.delegate?.changeView()
    }
    
    
    func configure(result:TestResult){
        
        switch result.TotalScore {
        case 70...100:
            label_grade.text = "1급"
            label_comment.text = "당신은 한국사 마스터!"
        case 60...69:
            label_grade.text = "2급"
            label_comment.text = "포기하지 마세요!"
        default:
            label_grade.text = "불합격"
            label_comment.text = "다음 시험을 준비하세요!"
        }
        
        label_correct.format = "%d"
        label_correct.method = .easeIn
        label_correct.animationDuration = 0.8
        label_correct.countFromZero(to: CGFloat(result.numberOfRight))
        
        
        label_Score.text = "\(result.TotalScore)"
        label_wrong.text = "\(result.numberOfWrong+result.numberOfPass)"
        
        gageView.currentValue = CGFloat((Float(result.numberOfRight)/Float(result.Tries.count)) * 100)
        
        
        let totalRate = Float(result.numberOfRight)/Float(result.Tries.count)
        var tryRate = Float(result.numberOfRight)/Float(result.Tries.count - result.numberOfPass)
        if tryRate.isNaN{tryRate = Float(0)}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.roundView1.setValue(value: CGFloat(totalRate*100), animate: true)
            self.roundView2.setValue(value: CGFloat(tryRate*100), animate: true)
        }
        
    }
    
}

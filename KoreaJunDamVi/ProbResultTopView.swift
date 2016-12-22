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
    
    gageView.currentValue = 80
    
    label_Trial.layer.cornerRadius = 6
    label_Score.layer.cornerRadius = 6
    
    
    
    label_correct.format = "%d"
    label_correct.method = .easeIn
    label_correct.animationDuration = 0.8
    label_correct.countFromZero(to: 50)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
      self.roundView1.currentValue = 40
      self.roundView2.currentValue = 80
    }
    
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
  
}

//
//  AnalBarChartView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 19..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

@IBDesignable class AnalBarChartView: UIView {
  var view:UIView!
  let NibName:String = "AnalBarChartView"
  
  @IBOutlet var heightOfBar1: NSLayoutConstraint!
  @IBOutlet var heightOfBar2: NSLayoutConstraint!
  @IBOutlet var heightOfBar3: NSLayoutConstraint!
  
  //30 , 35
  
  var maxRange:CGFloat!
  override var backgroundColor: UIColor?{
    didSet(value){
      guard value != nil else {
        return
      }
    }
  }
  
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
    
    
    
    
    
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:"AnalBarChartView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  
  override func layoutSubviews() {
    maxRange = self.height - 65
    
    
    
  }
  
  func testAnimate(){
    heightOfBar1.constant = maxRange/3
    heightOfBar2.constant = maxRange/3
    heightOfBar3.constant = maxRange/3
    
    UIView.animate(withDuration: 3) {
      self.layoutIfNeeded()
    }
  }
  
  
  
}

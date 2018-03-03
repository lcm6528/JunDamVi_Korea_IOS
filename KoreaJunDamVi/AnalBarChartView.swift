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
  let NibName: String = "AnalBarChartView"
  
  @IBOutlet var heightOfBar1: NSLayoutConstraint!
  @IBOutlet var heightOfBar2: NSLayoutConstraint!
  @IBOutlet var heightOfBar3: NSLayoutConstraint!
  
  @IBOutlet var grayBarTitleLabel: UILabel!
  @IBOutlet var blackBarTitleLabel: UILabel!
  @IBOutlet var redBarTitleLabel: UILabel!
  
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
  
  
  
  //30 , 35
  
  var maxRange:CGFloat!
  override var backgroundColor: UIColor?{
    didSet(value) {
      guard value != nil else {
        return
      }
    }
  }
  
  
  var valueForRedBar: Int! = 0
  var valueForBlackBar: Int! = 0
  var valueForGrayBar: Int! = 0
  
  
  
  
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
    
    
    
    setMaxRange()
    
    
    
    
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:"AnalBarChartView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  func setMaxRange() {
    maxRange = self.height - 65 - 60
  }
  
  func setValue(forRedBar val1: Int,BlackBar val2: Int, GrayBar val3: Int) {
    
    valueForRedBar = val1
    valueForBlackBar = val2
    valueForGrayBar = val3
    
  }
  
  
  func setBarUI(withAnimate animated:Bool) {
    
    
    redBarTitleLabel.text = "\(valueForRedBar!)"
    blackBarTitleLabel.text = "\(valueForBlackBar!)"
    grayBarTitleLabel.text = "\(valueForGrayBar!)"
    
    
    let sumOfVal = (valueForBlackBar + valueForGrayBar) as Int! + valueForRedBar
    heightOfBar1.constant = maxRange * CGFloat(Float(valueForRedBar)/Float(sumOfVal)) + 20
    heightOfBar2.constant = maxRange * CGFloat(Float(valueForBlackBar)/Float(sumOfVal)) + 20
    heightOfBar3.constant = maxRange * CGFloat(Float(valueForGrayBar)/Float(sumOfVal)) + 20
    
    if animated{
     animate()

    } else {
    self.layoutIfNeeded()  
    }
    
    
  }
  
  func animate() {
    
    
    let originHeight = [heightOfBar1.constant,heightOfBar2.constant,heightOfBar3.constant]
    heightOfBar1.constant = 20
    heightOfBar2.constant = 20
    heightOfBar3.constant = maxRange+20//20
    self.layoutIfNeeded()
    
    heightOfBar1.constant = originHeight[0]
    heightOfBar2.constant = originHeight[1]
    heightOfBar3.constant = originHeight[2]
    
    UIView.animate(withDuration: 1, animations: {
      self.layoutIfNeeded()
    })
    
    
  }
  
  
}

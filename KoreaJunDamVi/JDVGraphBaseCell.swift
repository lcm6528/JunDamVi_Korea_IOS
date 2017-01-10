//
//  JDVBanner.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 7. 15..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit


@IBDesignable class JDVGraphBaseCell: UIView {
  
  var view:UIView!
  
  
  let NibName:String = "JDVGraphBaseCell"
  
  var duration:Double = 1
  
  @IBOutlet var gageHeightConst: NSLayoutConstraint!
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var valueLabel: UILabel!
  @IBOutlet var gageView: UIView!
  @IBOutlet var separatorView: UIView!
  @IBOutlet var highlightBalloon: UIImageView!
  
  @IBOutlet var bottomConst: NSLayoutConstraint!
  
  var normalGageColor:UIColor!
  var highlightGagecolor:UIColor!
  
  
  
  var highlight:Bool = false{
    didSet{
      setHighlight(Bool: highlight)
    }
  }
  
  var currentValue:Float = 0 {
    didSet{
      valueLabel.text = "\(Int(currentValue))%"
    }
  }
  var title:String  = ""{
    didSet{
      titleLabel.text = title
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
  
  
  convenience init(title text: String, value val: Float) {
    self.init()

    title = text
    titleLabel.text = text
    currentValue = val
    valueLabel.text = "\(Int(val))%"

  }
  
  
  
  func setup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(view)
    
    
    
  }
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:NibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  func setHighlight(Bool val:Bool){
    
    gageView.backgroundColor = (val) ? highlightGagecolor : normalGageColor
    separatorView.backgroundColor = (val) ? highlightGagecolor : normalGageColor
    
    bottomConst.constant = (val) ? 8 : 0
    valueLabel.textColor = (val) ? UIColor.white : UIColor.black
    highlightBalloon.isHidden = (val) ? false : true
    valueLabel.font = (val) ? UIFont(name: "NanumBarunGothicBold", size: 10) : UIFont(name: "NanumBarunGothic", size: 11)
    
  }
  
  func setGageBackgroundColor(with color:UIColor){
    
    gageView.backgroundColor = color
    separatorView.backgroundColor = color
    
  }
  
  
  func setGageHeight(_ const:CGFloat, animate isAnimate:Bool){
    gageHeightConst.constant = 0
      self.layoutIfNeeded()
    if isAnimate{
      self.gageHeightConst.constant = const
      UIView.animate(withDuration: duration, animations: {
      
        self.layoutIfNeeded()
      })
    }else{
      gageHeightConst.constant = const
    }
  }
}

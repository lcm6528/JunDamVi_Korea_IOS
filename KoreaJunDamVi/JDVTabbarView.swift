//
//  JDVTabbarView.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 2..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit


protocol JDVTabbarDelegate{
  func JDVTabbar(_ tabbar:JDVTabbarView ,didSelectedButtonAtIndex index:Int)
}
@IBDesignable class JDVTabbarView: UIView {
  
  
  
  var JDVBlueColor:UIColor = UIColor(red: 56/255.0, green: 144/255.0, blue: 227/128.0, alpha: 1)
  
  var view:UIView!
  @IBOutlet var LButton: UIButton!
  @IBOutlet var RButton: UIButton!
  @IBOutlet var LLine: UIView!
  @IBOutlet var RLine: UIView!
  
  let NibName:String = "JDVTabbarView"
  
  var delegate:JDVTabbarDelegate?
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    setup()
    activeLButton()
    
  }
  
  
  required init(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)!
    setup()
    activeLButton()
  }
  
  func setup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:"JDVTabbarView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  
  
  @IBAction func buttonPressed(_ sender: UIButton) {
    
    selectButtonWithTag(tag: sender.tag)
    
    
  }
  
  func activeLButton() {
    LButton.isSelected = true
    LLine.backgroundColor = JDVBlueColor
    
    RButton.isSelected = false
    RLine.backgroundColor = UIColor.clear
    
  }
  
  func activeRButton() {
    
    RButton.isSelected = true
    RLine.backgroundColor = JDVBlueColor
    
    LButton.isSelected = false
    LLine.backgroundColor = UIColor.clear
    
  }
  
  
  func selectButtonWithTag(tag x: Int) {
    
    switch x {
    case 0:
      activeLButton()
      self.delegate?.JDVTabbar(self, didSelectedButtonAtIndex: 0)
    case 1:
      activeRButton()
            self.delegate?.JDVTabbar(self, didSelectedButtonAtIndex: 1)
    default:
      break;
    }
    
    
  }
  
  
  
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  
}

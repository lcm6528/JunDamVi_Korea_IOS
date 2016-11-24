//
//  JDVTestResultLabelView.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 17..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

@IBDesignable class JDVTestResultLabelView: UIView {
  
  var view:UIView!
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var valueLabel: UILabel!
  
  @IBInspectable var title:String?{
    get{
      return titleLabel.text
    }
    set(title){
      titleLabel.text = title
    }
  }
  
  var value:String?{
    get{
      return valueLabel.text
    }
    set(title){
      valueLabel.text = title
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
    let nib = UINib(nibName:"JDVTestResultLabelView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  
  
  
  
  
  
  
}

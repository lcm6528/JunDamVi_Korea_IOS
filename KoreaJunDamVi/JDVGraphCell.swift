//
//  JDVBanner.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 7. 15..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit


@IBDesignable class JDVGraphCell: UIView {
  
  var view:UIView!
  
  
  let NibName:String = "JDVGraphCell"
  
  
  
  
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
    let nib = UINib(nibName:NibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
}

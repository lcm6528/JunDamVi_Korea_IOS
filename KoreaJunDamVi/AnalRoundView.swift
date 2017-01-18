//
//  AnalRoundView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 18..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

@IBDesignable class AnalRoundView: UIView {

  
  
  
  var view:UIView!
  let NibName:String = "AnalRoundView"
  
  
  @IBOutlet var layerView: UIView!
  
  override var backgroundColor: UIColor?{
    didSet(value){
//      self.view.backgroundColor = UIColor.clear
      guard value != nil else {
        return
      }
      self.layerView.backgroundColor = value ?? UIColor.white
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
    
    
    self.backgroundColor = UIColor.clear
    
    
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:"AnalRoundView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  
  override func layoutSubviews() {
    
    layerView.layer.cornerRadius = self.width/2
    print(self.width)
    let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.width/2)
    
    layerView.layer.shadowRadius = 0.5
    layerView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    layerView.layer.shadowColor = UIColor.lightGray.cgColor
    layerView.layer.shadowPath = path.cgPath
    layerView.layer.shadowOpacity = 0.5
  }
  
  
  
}

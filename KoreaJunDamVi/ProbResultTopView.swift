//
//  ProbResultTopView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit



class ProbResultTopView: UIView {
  var view:UIView!
  let NibName:String = "ProbResultTopView"
  
  var delegate:ProbResultSubViewDelegate?
  @IBOutlet var gageView: GageView!
  
  
  
  
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

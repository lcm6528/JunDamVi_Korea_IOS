//
//  ProbResultBotView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit



class ProbResultBotView: UIView {
  
  var view:UIView!
  
  
  let NibName:String = "ProbResultBotView"
  
  var delegate:ProbResultSubViewDelegate?
  
  
  @IBOutlet var tableView: UITableView!
  
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
    tableView.register(UINib(nibName: "ProbResultBotCell", bundle: nil), forCellReuseIdentifier: "cell")
    let nib = UINib(nibName: "ResultBotHeaderView", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "ResultBotHeaderView")
    
    
    //testcode
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
    
    addSubview(view)
    
    
    
  }
  
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName:NibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0
      ] as! UIView
    
    
    return view
  }
  @IBAction func changeView(_ sender: AnyObject) {
    self.delegate?.changeView()
  }
  
  
}

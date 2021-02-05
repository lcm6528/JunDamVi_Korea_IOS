//
//  JBVViewController.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 2. 18..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit


class JDVViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  func setTitleWithImage(_ text: String) {
    let textt = " \(text)"
    
    let label: UILabel = UILabel(frame:    CGRect(x: 0, y: 0, width: 180, height: 40))
    
    let rawString:NSMutableAttributedString = NSMutableAttributedString(string: textt, attributes: [NSAttributedString.Key.font:UIFont(name: "NanumBarunGothicLight", size: 18)!,
                                                                                                    NSAttributedString.Key.foregroundColor:UIColor.white])
    
    let attachIcon:NSTextAttachment = NSTextAttachment()
    attachIcon.image = UIImage(named: "navi_icon")
    attachIcon.bounds = CGRect(x: 0, y: -5, width: 35, height: 22)
    
    let iconString:NSAttributedString = NSAttributedString(attachment: attachIcon)
    
    
    let titleString:NSMutableAttributedString = NSMutableAttributedString()
    titleString.append(iconString)
    titleString.append(rawString)
    
    
    label.attributedText = titleString
    label.textAlignment = NSTextAlignment.center
    
    
    self.navigationItem.titleView = label
    
  }
  
  
  
  
  func setTitleWithStyle(_ text: String) {
    
    let label: UILabel = UILabel(frame:    CGRect(x: 0, y: 0, width: 120, height: 40))
    
    let rawString:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.NaviBarTitleFont,
                                                                                                   NSAttributedString.Key.foregroundColor:UIColor.white])
    
    
    label.attributedText = rawString
    label.textAlignment = .center
    self.navigationItem.titleView = label
    
  }
  
}

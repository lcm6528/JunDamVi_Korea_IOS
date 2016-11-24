//
//  JDVRadioButtonManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 19..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
protocol JDVRadioButtonManagerDelegate{
  func JDVRadioButtonManagerDelegate(_ manager:JDVRadioButtonManager ,didSelectedButtonAtIndex index:Int)
}

class JDVRadioButtonManager: NSObject {
  
  var arrayOfButtons:[UIButton]!
  
  var tag:Int!
  
  var delegate:JDVRadioButtonManagerDelegate?
  
  init(WithButtons btn:UIButton ...){
    super.init()
    arrayOfButtons = btn
    for button in arrayOfButtons!{
      button.addTarget(self, action: #selector(JDVRadioButtonManager.buttonPressed(_:)), for: .touchUpInside)
      
    }
    
    deselectAll()
    
  }
  
  
  func buttonPressed(_ sender:UIButton){
    
    if sender.isSelected == true{
      deselectAll()
      self.delegate?.JDVRadioButtonManagerDelegate(self, didSelectedButtonAtIndex: -1)
      return
    }
    
    
    
    
    let index:Int = arrayOfButtons.index(of: sender)!
    sender.isSelected = true
    
    for button in arrayOfButtons!{
      
      if button === sender{
        
        continue
      }
      button.isSelected = false
      
    }
    
    
    self.delegate?.JDVRadioButtonManagerDelegate(self, didSelectedButtonAtIndex: index)
  }
  
  
  func deselectAll(){
    for button in arrayOfButtons{
      
      button.isSelected = false
      
    }
  }
  
  func selectButtonAtIndex(_ index:Int){
    
    if index == -1{
      deselectAll()
      return
    }
    
    for button in arrayOfButtons{
      
      button.isSelected = false
      
      if button === arrayOfButtons[index]{
        button.isSelected = true
      }
      
    }
    
  }
  
}

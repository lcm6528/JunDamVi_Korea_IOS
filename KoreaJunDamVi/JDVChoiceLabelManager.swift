//
//  JDVChoiceLabelManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 4. 26..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
protocol JDVChoiceLabelManagerDelegate{
  
  func JDVChoiceLabelManagerDelegate(_ manager:JDVChoiceLabelManager ,didSelectedLabelAtIndex index:Int)
  
}
class JDVChoiceLabelManager: NSObject {
  
  enum StateOfChoice{
    case selected
    case auth
    case normal
  }
  
  
  
  var isActive:Bool?{
    get{
      return self.isActive
    }
    set(isActive){
      
      if isActive == true{
        for label in arrayOfLabels{
          label.isUserInteractionEnabled = true
        }
      }else{
        for label in arrayOfLabels{
          label.isUserInteractionEnabled = false
        }
      }
      
    }
  }
  
  var arrayOfLabels:[UILabel]!
  var indexOfPage:Int!
  
  var delegate:JDVChoiceLabelManagerDelegate?
  
  init(WithLabels label:UILabel ...){
    super.init()
    arrayOfLabels = label
    
    for label in arrayOfLabels!{
      let gesture = UITapGestureRecognizer(target: self, action:#selector(JDVChoiceLabelManager.touchOnLabel(_:)))
      label.addGestureRecognizer(gesture)
      label.adjustsFontSizeToFitWidth = true

      
    }
    
  }
  
  func touchOnLabel(_ sender:UITapGestureRecognizer){
  
    let index:Int = arrayOfLabels.index(of: sender.view as! UILabel)!
    selectLabelAtIndex(index)
    
    
    
    self.delegate?.JDVChoiceLabelManagerDelegate(self, didSelectedLabelAtIndex: index)
  }
  
  
  func setColorForStateAtIndex(_ index:Int, state:StateOfChoice){
    switch state{
    case .selected:
      arrayOfLabels[index].backgroundColor = UIColor.lightGray
      
      
    case .auth:
      arrayOfLabels[index].backgroundColor = ThemeColor
      
      
    case .normal:
      arrayOfLabels[index].backgroundColor = UIColor.lightGray
      
    }
    
  }
  
  func selectLabelAtIndex(_ index:Int){
    
    for label in arrayOfLabels{
      
      if label === arrayOfLabels[index]{
        label.backgroundColor = UIColor.lightGray
        continue
      }
      label.backgroundColor = UIColor.clear
      
      
    }
  }
  
    
  
}

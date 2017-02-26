//
//  JDVChoiceLabelManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 4. 26..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
protocol JDVChoiceViewManagerDelegate{
  
  func JDVChoiceViewManagerDelegate(_ manager:JDVChoiceViewManager ,didSelectedLabelAtIndex index:Int)
  
}
class JDVChoiceViewManager: NSObject {
  
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
        for view in arrayOfViews{
          view.isUserInteractionEnabled = true
        }
      }else{
        for view in arrayOfViews{
          view.isUserInteractionEnabled = false
        }
      }
      
    }
  }
  
  var arrayOfViews:[UIView]!
  var indexOfPage:Int!
  
  var delegate:JDVChoiceViewManagerDelegate?
  
  init(WithViews views:UIView ...){
    super.init()
    arrayOfViews = views
    
    for label in arrayOfViews!{
      let gesture = UITapGestureRecognizer(target: self, action:#selector(JDVChoiceViewManager.touchOnLabel(_:)))
      label.addGestureRecognizer(gesture)

      
    }
    
  }
  
  func touchOnLabel(_ sender:UITapGestureRecognizer){
  
    let index:Int = arrayOfViews.index(of: sender.view!)!
    selectLabelAtIndex(index)
    
    
    
    self.delegate?.JDVChoiceViewManagerDelegate(self, didSelectedLabelAtIndex: index)
  }
  
  
  func setColorForStateAtIndex(_ index:Int, state:StateOfChoice){
    switch state{
    case .selected:
      arrayOfViews[index].backgroundColor = UIColor.lightGray
      
      
    case .auth:
      arrayOfViews[index].backgroundColor = ThemeColor
      
      
    case .normal:
      arrayOfViews[index].backgroundColor = UIColor.lightGray
      
    }
    
  }
  
  func selectLabelAtIndex(_ index:Int){
    
    for view in arrayOfViews{
      
      if view === arrayOfViews[index]{
        view.backgroundColor = UIColor.selectedRed
        continue
      }
      view.backgroundColor = UIColor.white
      
      
    }
  }
  
    
  
}

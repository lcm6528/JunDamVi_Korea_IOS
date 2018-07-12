//
//  JDVGraphModel.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 29..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class JDVGraphDataItem {
  var title: String
  var value:Float
  var standings: Int

  var description: String{
    return "\(title) : \(value) / \(standings)"
  }
  
  init(title text: String = "" , value val:Float = 0) {
    title = text
    value = val
    standings = 1
  }
  
  
  
}



class JDVGraphModel: NSObject {
  
  var Items:[JDVGraphDataItem] = []
  
  var minValue:Float = 0
  var maxValue:Float = 0
  
  
  init(arrayLiteral:[(String,Float)]) {
    
    
    for element in arrayLiteral {
      let item = JDVGraphDataItem(title: element.0, value: element.1)
      
      Items.append(item)
    }
    
    maxValue = Items.max { $0.value < $1.value }!.value
    minValue = Items.min { $0.value < $1.value }!.value
    
    for item in Items{
      for item2 in Items{
        if item.value < item2.value {item.standings += 1}
      }
    }
    
  }
  
}

//
//  JDVGraphModel.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 29..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class JDVGraphDataItem {
  var title:String
  var value:Int
  var standings:Int
  
  var description:String{
    return "\(title) : \(value) / \(standings)"
  }
  init(title text:String = "" , value val:Int = 0) {
    title = text
    value = val
    standings = 1
  }
  
  
  
}
class JDVGraphModel: NSObject {
  
  var Items:[JDVGraphDataItem] = []
  
  init(arrayLiteral:[(String,Int)]) {
    
    
    for element in arrayLiteral{
      let item = JDVGraphDataItem(title: element.0, value: element.1)
      print(element.0)
      Items.append(item)
    }
    
    
    for item in Items{
      for item2 in Items{
        if item.value < item2.value {item.standings += 1}
      }
    }
    
  }
  
}

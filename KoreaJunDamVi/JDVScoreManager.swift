//
//  JDVScoreManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 16..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

class JDVScoreManager: NSObject {

  
  
  
  static func getScoreOfLang(_ year:Int, score:Int)->(Double){
    
    let path = Bundle.main.path(forResource: "document", ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
    var dict = NSDictionary()
    do {
      let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
      dict = object as! NSDictionary
      
    } catch {
      // Handle Error
    }

    let selectedDict = dict["\(year)"] as! NSDictionary
    let test1Array = selectedDict["test1"] as! NSArray
    
    if 0..<test1Array.count ~= score{
      
      return Double(test1Array[score] as! String)!
      
    }else{
      return -1
    }
  }
  
  static func getScoreOfReas(_ year:Int, score:Int)->(Double){
    
    let path = Bundle.main.path(forResource: "document", ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
    var dict = NSDictionary()
    do {
      let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
      dict = object as! NSDictionary
      
    } catch {
      // Handle Error
    }
    
    let selectedDict = dict["\(year)"] as! NSDictionary
    let test1Array = selectedDict["test2"] as! NSArray
    
    if 0..<test1Array.count ~= score{
      
      return Double(test1Array[score] as! String)!
      
    }else{
      return -1
    }
    
  }
  
  
  static func getCountOfTest(_ year:Int)->(Int){
    
    let path = Bundle.main.path(forResource: "document", ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
    var dict = NSDictionary()
    do {
      let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
      dict = object as! NSDictionary
      
    } catch {
      // Handle Error
    }
    
    let selectedDict = dict["\(year)"] as! NSDictionary
    let test1Array = selectedDict["test2"] as! NSArray
    
    return test1Array.count
    
  }
  
  
  static func getTime(_ year:Int, type:String)-> Int{
    let keyString = "\(year)\(type)"
    var time  = getUserDefaultIntValue(keyString)
    
    if time == 0{
      
      time = 1
    }
    
    return time
    
  }
  

}

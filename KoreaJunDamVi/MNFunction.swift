//
//  MNFunction.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 27..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH  = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let NaviBar_Height = 44
let StatusBar_Height = 20


func getHeightOfStatusNNaviBar(_ vc:UIViewController)->CGFloat{
  
  let height = vc.navigationController?.navigationBar.frame.size.height ?? 0
  return height + 20
  
}


func stringToAttrStringInHTML(_ str:String) -> NSAttributedString{
  var attrString = NSMutableAttributedString()
  
  do{
    attrString = try NSMutableAttributedString(data: str.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
  }catch{}
  
  let result = attrString.copy() as! NSAttributedString
  return result
}


func setUserDefault(_ value:AnyObject, forKey key:String){
  UserDefaults.standard.setValue(value, forKey: key)
}
func setUserDefaultWithInt(_ value:Int, forKey key:String){
  UserDefaults.standard.set(value, forKey: key)
 
  
}


func setUserDefaultWithBool(_ value:Bool, forKey key:String){
   UserDefaults.standard.set(value, forKey: key)
}

func getUserDefaultBoolValue(_ key:String) -> Bool{
  let value = UserDefaults.standard.bool(forKey: key)
  return value
}



func getUserDefault(_ key:String) -> AnyObject{
  if let value = UserDefaults.standard.object(forKey: key){
    return value as AnyObject
  }else{
    return NSNull()
  }
}
func getUserDefaultIntValue(_ key:String) -> Int{
  let value = UserDefaults.standard.integer(forKey: key)
  return value
}

func showAlertWithString(_ title:String , message:String, sender:UIViewController){
  let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
  alert.addAction(UIAlertAction(title: "닫기", style: UIAlertActionStyle.cancel, handler: nil))
  sender.present(alert, animated: true, completion: nil)
}


var isBlockUserInteract:Bool = false{
    didSet{
        if isBlockUserInteract != oldValue{
            isBlockUserInteract ? UIApplication.shared.beginIgnoringInteractionEvents() : UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

//
//  JDVFunctions.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 10..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import Foundation
import UIKit
enum SortingOption{
  case date
  case year
}

let GA_TrackingID = "UA-73399125-1"


enum gaViewId:String{
  case mainView = "GA - 메인메뉴 페이지"
  case probMenuView = "GA - 문제풀이 메뉴 페이지"
  case probTestViewHeader = "GA - 문제 풀이 페이지, "
  case quickTestViewHeader = "GA - 빠른 채점 페이지, "
  case noteMenuView = "GA - 오답노트 메뉴 페이지"
  case noteViewHeader = "오답노트 보기 페이지"
  case soluMenuView = "GA - 해설 메뉴 페이지"
  case soluViewHeader = "GA - 해설 보기 페이지, "
  case timerView = "GA - 타이머 페이지"
  case calcView = "GA - 빠른 표준점수 페이지"
}

let fontsizeOfChoices:CGFloat = 14.0
let fontsizeOfArticle:CGFloat = 18.0
let fontsizeOfbasic:CGFloat = 14.0
let fontsizeOfguide:CGFloat = 14.0
let fontsizeOfproblem:CGFloat = 17.0

let font_guide_lang:UIFont = UIFont(name: "NanumMyeongjoExtraBold", size: fontsizeOfguide)!
let font_guide_reas:UIFont = UIFont(name: "NanumMyeongjo", size: fontsizeOfproblem)!


let ThemeColor = UIColor(red: 56/255.0, green: 144/255.0, blue: 227/255.0, alpha:0.7)
let RedColor = UIColor(red: 235/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)

let ProbLineSpace:CGFloat = 8
let SolLineSpace:CGFloat = 6

extension Date
{
  
  init(dateString:String) {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "yyyyMMdd"
    dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
    let d = dateStringFormatter.date(from: dateString)!
    self.init(timeInterval:0, since:d)
  }
}
public extension UIDevice {
  
  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8 , value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
    case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
    case "iPhone8,4":                               return "iPhone SE"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
  }
  
}

extension UIView{
  var width:      CGFloat { return self.frame.size.width }
  var height:     CGFloat { return self.frame.size.height }
  var size:       CGSize  { return self.frame.size}
  
  var origin:     CGPoint { return self.frame.origin }
  var x:          CGFloat { return self.frame.origin.x }
  var y:          CGFloat { return self.frame.origin.y }
  var centerX:    CGFloat { return self.center.x }
  var centerY:    CGFloat { return self.center.y }
  
  var left:       CGFloat { return self.frame.origin.x }
  var right:      CGFloat { return self.frame.origin.x + self.frame.size.width }
  var top:        CGFloat { return self.frame.origin.y }
  var bottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
  
  func setWidth(width:CGFloat)
  {
    self.frame.size.width = width
  }
  
  func setHeight(height:CGFloat)
  {
    self.frame.size.height = height
  }
  
  func setSize(size:CGSize)
  {
    self.frame.size = size
  }
  
  func setOrigin(point:CGPoint)
  {
    self.frame.origin = point
  }
  
  func setX(x:CGFloat) //only change the origin x
  {
    self.frame.origin = CGPoint(x:x,y: self.frame.origin.y)
  }
  
  func setY(y:CGFloat) //only change the origin x
  {
    self.frame.origin = CGPoint(x:self.frame.origin.x, y:y)
  }
  
  func setCenterX(x:CGFloat) //only change the origin x
  {
    self.center = CGPoint(x:x,y: self.center.y)
  }
  
  func setCenterY(y:CGFloat) //only change the origin x
  {
    self.center = CGPoint(x:self.center.x, y:y)
  }
  
  func roundCorner(radius:CGFloat)
  {
    self.layer.cornerRadius = radius
  }
  
  func setTop(top:CGFloat)
  {
    self.frame.origin.y = top
  }
  
  func setLeft(left:CGFloat)
  {
    self.frame.origin.x = left
  }
  
  func setRight(right:CGFloat)
  {
    self.frame.origin.x = right - self.frame.size.width
  }
  
  func setBottom(bottom:CGFloat)
  {
    self.frame.origin.y = bottom - self.frame.size.height
  }
}

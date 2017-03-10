//
//  Prob.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 23..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions

enum Prob_time: String{
  
  case chosun = "조선"
  case korea = "고려"
  
}

enum Prob_type: String{
  case hesuk = "해석형"
  case theme = "테마형"
  
}

enum Prob_theme: String{
  
  case wang = "왕"
  case zedo = "제도"
  
}


struct Prob {
  var ProbID:Int
  var TestNum:Int
  var ProbNum:Int
  
  var Score:Int
  var Score_String:String?
  
  var Answer:Int
  var title_String:String
  var title_attString: NSAttributedString?
  
  var article_String:String
  var article_attString:NSAttributedString?
  
  var choices_String:[String] = []
  var choices_attString:[NSAttributedString] = []
  
  var time:Prob_time?
  var type:Prob_type?
  var theme:Prob_theme?
  
  var tags:[String]?
  
  init(withDict dict:NSDictionary){
    
    self.ProbID = dict["probId"] as! Int
    self.TestNum = dict["testnum"] as! Int
    self.ProbNum = dict["probnum"] as! Int
    self.Answer = dict["answer"] as! Int
    self.Score = dict["score"] as! Int
    self.title_String = dict["title"] as! String
    self.article_String = dict["article"] as! String
    
    
    setChoices(withArray: [dict["choice1"] as! String,dict["choice2"] as! String,dict["choice3"] as! String,dict["choice4"] as! String,dict["choice5"] as! String])
    setTestAtt()
    setArticleAtt()
    
  }
  
  
  mutating func setTestAtt(){
    
    let title = NSMutableAttributedString(string: "\(self.ProbNum). ")
    title.append(stringToAttrStringInHTML(title_String))
    title.addAttribute(NSFontAttributeName, value: UIFont.titleFont, range: NSRange(location: 0, length: title.length))
    self.title_attString = title
    
  }
  
  mutating func setArticleAtt(){
    //parse image here
    
    
    
    let result =  replaceTagToImage(withString: article_String, imgName: "\(ProbID)")
    result.addAttribute(NSFontAttributeName, value: UIFont.articleFont, range: NSRange(location: 0, length: result.length))
    
    self.article_attString = result
    
    
  }
  
  
  mutating func setChoices(withArray arr:[String]){
    choices_String = arr
    
    for (index,choice) in choices_String.enumerated(){
      let name = String(format: "%d_%02d", ProbID,index+1)
      let result = replaceTagToImage(withString: choice, imgName: name, withWidth: SCREEN_WIDTH/4)
      
      result.addAttribute(NSFontAttributeName, value: UIFont.choiceFont, range: NSRange(location: 0, length: result.length))
      choices_attString.append(result)
      
    }
    
    
  }
  
  mutating func setTTT(time timeval:Prob_time, type typeval:Prob_type, theme themeval:Prob_theme){
    self.time = timeval
    self.type = typeval
    self.theme = themeval
    
  }
  
  mutating func setTags(withArr arr:[String]){
    self.tags = arr
  }
  
  
  func replaceTagToImage(withString str:String, imgName name:String, withWidth width:CGFloat = SCREEN_WIDTH - 20)->NSMutableAttributedString{
    
    let arr = str.components(separatedBy: "/img/")
    
    //No image in str
    if arr.count == 1 {
      return NSMutableAttributedString(attributedString: stringToAttrStringInHTML(str))
    }
    
    
    let result = NSMutableAttributedString()
    
    result.append(stringToAttrStringInHTML(arr[0]))
    result.append(NSAttributedString(string: "\n"))
    //Append Image
    let attachIcon:NSTextAttachment = NSTextAttachment()
    let bundlePath = Bundle.main.path(forResource: name, ofType: "png")
    attachIcon.image = UIImage(contentsOfFile: bundlePath!)
    let scaleFactor = attachIcon.image!.size.width / (width)
    attachIcon.image = UIImage(cgImage: attachIcon.image!.cgImage!, scale: scaleFactor, orientation: UIImageOrientation.up)
    
    let imageString = NSAttributedString(attachment: attachIcon)
    result.append(imageString)
    ///////////////
    result.append(NSAttributedString(string: "\n"))
    result.append(stringToAttrStringInHTML(arr[1]))
    
    return result
    
  }
  
  
  
  
}

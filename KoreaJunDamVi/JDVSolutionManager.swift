//
//  JDVSolutionManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 6. 29..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import FMDB

class JDVSolutionManager: NSObject {

  
  
  
  static func getSolDictByYear(_ year:Int, forType type:String, forNum num:Int)->NSDictionary{
    
    var arrayOfSol = [NSDictionary]()
    
    
    let dbPath = Bundle.main.url(forResource: "Solutions", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      
      let sql = "SELECT * FROM \(type) WHERE year = \(year) and num = \(num)"
      let result = fmdb?.executeQuery(sql, withArgumentsIn: nil)
      while result?.next() == true {
        let dict:NSDictionary = result!.resultDictionary() as NSDictionary
        arrayOfSol.append(dict)
        
      }
      
    }
    fmdb?.close()
    
    return arrayOfSol.first!
  }
  
  static func getSolArrayByYear(_ year:Int, forType type:String)->([NSDictionary]){
    var arrayOfSol = [NSDictionary]()
    
    let dbPath = Bundle.main.url(forResource: "Solutions", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      
      let sql1 = "SELECT * FROM \(type) WHERE year = \(year) order by num"
      let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
      while result?.next() == true {
        let dict:NSDictionary = result!.resultDictionary() as NSDictionary
        arrayOfSol.append(dict)
        
      }
    }
    fmdb?.close()
    return arrayOfSol
  }
  
  
  static func mergeArticleWithImage(_ dict:NSDictionary, forType type:String)->(NSMutableAttributedString){
    
    let count:Int = dict["count"] as! Int
    let articleString = NSMutableAttributedString()
    
    for i in 1...count{
      let attrStr = stringToAttrStringInHTML(dict["article_0\(i)"] as! String)
      articleString.append(attrStr)
      
      if i != count{
        let attachIcon:NSTextAttachment = NSTextAttachment()
        let name = "prob_\(type)_article_img0\(i)_\(dict["article_index"]!)"
        
        let bundlePath = Bundle.main.path(forResource: name, ofType: "jpg")
        attachIcon.image = UIImage(contentsOfFile: bundlePath!)
        
        let scaleFactor = attachIcon.image!.size.width / (SCREEN_WIDTH - 20)
        attachIcon.image = UIImage(cgImage: attachIcon.image!.cgImage!, scale: scaleFactor, orientation: UIImageOrientation.up)
        
        let imageString = NSAttributedString(attachment: attachIcon)
        
        articleString.append(imageString)
      }
    }
    articleString.addAttribute(NSFontAttributeName,
                               value: UIFont(
                                name: "NanumMyeongjo",
                                size: fontsizeOfArticle)!,
                               range: NSRange(location: 0, length: articleString.length)
    )
    return articleString
  }
  
  
  
  static func mergeProblemWithImage(_ dict:NSDictionary, forType type:String)->(NSMutableAttributedString){
    
    let count:Int = dict["attatchment"] as! Int
    let problemString = NSMutableAttributedString()
    
    if type == "reas"{
      return problemString
    }
    
    let attrStr = stringToAttrStringInHTML(dict["problem"] as! String)
    problemString.append(attrStr)
    if count != 0{
      let attachIcon:NSTextAttachment = NSTextAttachment()
      let name = String(format: "prob_\(type)_problem_img01_%d_%02d",dict["year"] as! Int ,dict["num"] as! Int)
      
      let bundlePath = Bundle.main.path(forResource: name, ofType: "jpg")
      attachIcon.image = UIImage(contentsOfFile: bundlePath!)
      let scaleFactor = attachIcon.image!.size.width / (SCREEN_WIDTH - 20)
      attachIcon.image = UIImage(cgImage: attachIcon.image!.cgImage!, scale: scaleFactor, orientation: UIImageOrientation.up)
      
      let imageString = NSAttributedString(attachment: attachIcon)
      
      problemString.append(imageString)
      
      
    }
    
    problemString.addAttribute(NSFontAttributeName,
                               value: UIFont(
                                name: "NanumMyeongjo",
                                size: fontsizeOfproblem)!,
                               range: NSRange(location: 0, length: problemString.length)
    )
    return problemString
  }
  
  
  static func mergeSolWithImage(_ dict:NSDictionary, fortype type:String, forKey key:String)->(NSMutableAttributedString){
    
    let count = dict["\(key)_COUNT"] as! Int
    if count == 0 {
      return NSMutableAttributedString()
    }
    let solAttString = NSMutableAttributedString()
    
    for i in 1...count{
      if i%2 == 1{
        
        let attrStr = stringToAttrStringInHTML(dict["\(key)_\(i)"] as! String)
        solAttString.append(attrStr)
        
      }else{
        
        let attachIcon:NSTextAttachment = NSTextAttachment()
        let name = dict["\(key)_\(i)"] as! String
        
        let bundlePath = Bundle.main.path(forResource: name, ofType: "png")
        attachIcon.image = UIImage(contentsOfFile: bundlePath!)
        
        let scaleFactor = attachIcon.image!.size.width / (SCREEN_WIDTH - 20)
        attachIcon.image = UIImage(cgImage: attachIcon.image!.cgImage!, scale: scaleFactor, orientation: UIImageOrientation.up)
        
        let imageString = NSAttributedString(attachment: attachIcon)
        
        solAttString.append(imageString)
      }
      
      
      
      
      
      
    }
    solAttString.addAttribute(NSFontAttributeName,
                              value: UIFont(
                                name: "NanumMyeongjo",
                                size: fontsizeOfArticle)!,
                              range: NSRange(location:0 , length: solAttString.length)
    )
      

    
    return solAttString
    
    
    
  }
  
  static func resetSolution(){
    let arr = ["JDVLeetLang2016","JDVLeetLang2015","JDVLeetLang2014","JDVLeetLang2013","JDVLeetLang2012","JDVLeetLang2011","JDVLeetLang2010","JDVLeetLang2009","JDVLeetReas2016","JDVLeetReas2015","JDVLeetReas2014","JDVLeetReas2013","JDVLeetReas2012","JDVLeetReas2011","JDVLeetReas2010","JDVLeetReas2009"]
    
    for sol in arr{
      setUserDefaultWithBool(false, forKey: sol)
    }
  }
  
  static func LangPass(){
    let arr = ["JDVLeetLang2016","JDVLeetLang2015","JDVLeetLang2014","JDVLeetLang2013","JDVLeetLang2012","JDVLeetLang2011","JDVLeetLang2010","JDVLeetLang2009"]
    
    for sol in arr{
      setUserDefaultWithBool(true, forKey: sol)
    }
    
  }
  
  static func ReasPass(){
    
    let arr = ["JDVLeetReas2016","JDVLeetReas2015","JDVLeetReas2014","JDVLeetReas2013","JDVLeetReas2012","JDVLeetReas2011","JDVLeetReas2010","JDVLeetReas2009"]
    
    for sol in arr{
      setUserDefaultWithBool(true, forKey: sol)
    }
  }
  
  static func setBuySolutionByID(_ idStr:String){
    setUserDefaultWithBool(true, forKey: idStr)
  }
  
  static func getStateOfSolutionByID(_ idStr:String)->Bool{
    return getUserDefaultBoolValue(idStr)
  }
  

}

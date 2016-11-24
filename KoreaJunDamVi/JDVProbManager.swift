//
//  JDVProbManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 6. 28..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import FMDB

class JDVProbManager: NSObject {
  
  
  static func getArticleDictByIndex(_ index:String, forType type:String)->NSDictionary{
    
    var arrayOfArticle = [NSDictionary]()
    
    let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      
      let sql = "SELECT * FROM Articles_\(type) WHERE article_index = '\(index)'"
      let result = fmdb?.executeQuery(sql, withArgumentsIn: nil)
      while result?.next() == true {
        let dict:NSDictionary = result!.resultDictionary() as NSDictionary
        arrayOfArticle.append(dict)
      }
      
    }
    fmdb?.close()
    
    return arrayOfArticle.first!
  }
  static func getProbDictByYear(_ year:Int, forType type:String, forNum num:Int)->NSDictionary{
    
    var arrayOfProb = [NSDictionary]()
    
    
    let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      
      let sql = "SELECT * FROM Prob_\(type) WHERE year = \(year) and num = \(num)"
      let result = fmdb?.executeQuery(sql, withArgumentsIn: nil)
      while result?.next() == true {
        let dict:NSDictionary = result!.resultDictionary() as NSDictionary
        arrayOfProb.append(dict)
        
      }
      
    }
    fmdb?.close()
    
    return arrayOfProb.first!
  }
  
  static func getProbArrayByYear(_ year:Int, forType type:String)->([NSDictionary]){
    var arrayOfProb = [NSDictionary]()
    
    let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      
      let sql1 = "SELECT * FROM Prob_\(type) WHERE year = \(year)"
      let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
      while result?.next() == true {
        let dict:NSDictionary = result!.resultDictionary() as NSDictionary
        arrayOfProb.append(dict)
        
      }
    }
    fmdb?.close()
    return arrayOfProb
  }
  
  
  static func getArticleArrayByYear(_ year:Int, forType type:String)->([NSDictionary]){
    
    var arrayOfArticle = [NSDictionary]()
    
    let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
    let fmdb = FMDatabase(path: dbPath?.path)
    
    if (fmdb?.open())! {
      let sql2 = "SELECT * FROM Articles_\(type) WHERE year = \(year)"
      let result2 = fmdb?.executeQuery(sql2, withArgumentsIn: nil)
      while result2?.next() == true {
        let dict2:NSDictionary = result2!.resultDictionary() as NSDictionary
        arrayOfArticle.append(dict2)
        
      }
      
    }
    fmdb?.close()
    return arrayOfArticle
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

  
}

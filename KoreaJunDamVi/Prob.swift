//
//  Prob.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 23..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation

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
  
  var TestNum:Int
  var ProbNum:Int
  var Score:Int
  
  var title_String:String{
    didSet{
     self.title_attString = stringToAttrStringInHTML(title_String)
    }
  }
  var article_String:String{
    didSet{
      setArticleAttString(str: article_String)
    }
  }
  
  var title_attString:NSMutableAttributedString?
  var article_attString:NSMutableAttributedString?
  
  var choices:[String]?
  
  var time:Prob_time?
  var type:Prob_type?
  var theme:Prob_theme?
  
  var tags:[String]?
  
  init(testnum:Int, probnum:Int, score:Int, title:String, article:String){
    
    self.TestNum = testnum
    self.ProbNum = probnum
    self.Score  = score
    self.title_String = title
    self.article_String = article
    
  }
  
  mutating func setChoices(withArray arr:[String]){
    self.choices = arr
  }
  
  mutating func setTTT(time timeval:Prob_time, type typeval:Prob_type, theme themeval:Prob_theme){
    self.time = timeval
    self.type = typeval
    self.theme = themeval
    
  }
  
  mutating func setTags(withArr arr:[String]){
    self.tags = arr
  }
  
  mutating func setArticleAttString(str:String){
    
    
    
  }
  
  
  
  
}

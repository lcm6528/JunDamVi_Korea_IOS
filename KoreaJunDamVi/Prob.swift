//
//  Prob.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 23..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit
import NSAttributedString_DDHTML

struct Prob {
    var ProbID: Int
    var TestNum: Int
    var ProbNum: Int
    
    var Score: Int
    var Score_String: String?
    
    var Answer: Int
    var title_String: String
    var title_attString: NSAttributedString?
    var title_attString_noNum: NSAttributedString?
    var title_attString_probId: NSAttributedString?
    
    var article_String: String
    var article_attString:NSAttributedString?
    
    var choices_String:[ String] = []
    var choices_attString:[NSAttributedString] = []
    
    var time: String
    var type: String
    var theme: String
    var tags: String
    
    var desc: String {
        return "\(time) / \(type) / \(theme)"
    }
    
    init(withDict dict:NSDictionary) {
        self.ProbID = dict["probId"] as! Int
        self.TestNum = dict["testnum"] as! Int
        self.ProbNum = dict["probnum"] as! Int
        self.Answer = dict["answer"] as! Int
        self.Score = dict["score"] as! Int
        self.title_String = dict["title"] as! String
        self.article_String = dict["article"] as? String ?? ""
        
        self.time = dict["time"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
        self.theme = dict["theme"] as? String ?? ""
        self.tags = dict["tags"] as? String ?? ""
        
        setChoices(withArray: [dict["choice1"] as! String,dict["choice2"] as! String,dict["choice3"] as! String,dict["choice4"] as! String,dict["choice5"] as! String])
        setTestAtt()
        setArticleAtt()
    }
    
    mutating func setTestAtt() {
        let probId = NSMutableAttributedString(string: "[\(self.TestNum)회 \(self.ProbNum)번] ")
        let title = NSMutableAttributedString(string: "\(self.ProbNum). ")
        let str = NSAttributedString(fromHTML: title_String)
        
        title.append(str)
        title.addAttribute(NSAttributedString.Key.font, value: UIFont.titleFont, range: NSRange(location: 0, length: title.length))
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textBlack0, range: NSRange(location: 0, length: title.length))
        
        let titleNoNum = NSMutableAttributedString(attributedString: str)
        titleNoNum.addAttribute(NSAttributedString.Key.font, value: UIFont.titleFont, range: NSRange(location: 0, length: titleNoNum.length))
        titleNoNum.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textBlack0, range: NSRange(location: 0, length: titleNoNum.length))
        
        
        probId.append(str)
        probId.addAttribute(NSAttributedString.Key.font, value: UIFont.titleFont, range: NSRange(location: 0, length: probId.length))
        probId.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textBlack0, range: NSRange(location: 0, length: probId.length))
        
        
        self.title_attString_probId = probId
        self.title_attString_noNum = titleNoNum
        self.title_attString = title
    }
    
    mutating func setArticleAtt() {
        let imageWidthRatio: CGFloat = UIDevice.current.isIPadOrLandscape ? 0.4 : 0.8
        let result = replaceTagToImage(withString: article_String, imgName: "\(ProbID)", withWidth: SCREEN_WIDTH * imageWidthRatio)
        result.addAttribute(NSAttributedString.Key.font, value: UIFont.articleFont, range: NSRange(location: 0, length: result.length))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ProbLineSpace
        result.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.textBlack0, range: NSRange(location: 0, length: result.length))
        
        
        self.article_attString = result
    }
    
    mutating func setChoices(withArray arr:[String]) {
        choices_String = arr
        
        for (index,choice) in choices_String.enumerated() {
            let name = String(format: "%d_%02d", ProbID,index + 1)
            let imageWidthRatio: CGFloat = UIDevice.current.isIPadOrLandscape ? 0.15 : 0.5
            let result = replaceTagToImage(withString: choice, imgName: name, withWidth: SCREEN_WIDTH * imageWidthRatio)
            
            result.addAttribute(NSAttributedString.Key.font, value: UIFont.choiceFont, range: NSRange(location: 0, length: result.length))
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = ProbLineSpace
            result.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
            
            choices_attString.append(result)
        }
    }
    
    func replaceTagToImage(withString str: String, imgName name: String, withWidth width:CGFloat = SCREEN_WIDTH * 0.9) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        if let bundlePath = Bundle.main.url(forResource: name, withExtension: "jpg") {
            
            if let imageData = try? Data(contentsOf: bundlePath),
                let image = UIImage(data: imageData),
                let origin = image.cgImage {
                
                let attachIcon:NSTextAttachment = NSTextAttachment()
                let scaleFactor = image.size.width / (width)
                let newImage = UIImage(cgImage: origin, scale: scaleFactor, orientation: UIImage.Orientation.up)
                attachIcon.image = newImage
                let imageString = NSAttributedString(attachment: attachIcon)
                result.append(imageString)
            }
            
            
            result.append(NSAttributedString(string: "\n"))
        }
        
        result.append(NSAttributedString(fromHTML:str))
        return result
    }
}

struct QuickProb {
    var ProbID: Int
    var TestNum: Int
    var ProbNum: Int
    var Score: Int
    var Answer: Int
    
    init(withDict dict:NSDictionary) {
        self.ProbID = dict["probId"] as! Int
        self.TestNum = dict["testnum"] as! Int
        self.ProbNum = dict["probnum"] as! Int
        self.Answer = dict["answer"] as! Int
        self.Score = dict["score"] as! Int
    }
}

//
//  Solution.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 21..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions

struct Solution {
    var ProbID:Int
    var TestNum:Int
    var ProbNum:Int
    
    var keyword_String:String
    var keyword_attString: NSAttributedString?{
        return setToAttr(from: keyword_String)
    }
    
    var content1_String:String
    var content1_attString:NSAttributedString?{
        return setToAttrWithImage(from: content1_String)
    }
    
    var content2_String:String
    var content2_attString:NSAttributedString?{
        return setToAttr(from: content2_String)
    }
    
    init(){
        
        self.ProbID = 0
        self.TestNum = 0
        self.ProbNum = 0
        
        self.keyword_String = "해당 회차 해설은 준비중입니다. 빠른 시일 내에 업데이트 될 예정입니다."
        self.content1_String = ""
        self.content2_String = ""
        
        
    }
    init(withDict dict:NSDictionary){
        
        self.ProbID = dict["probId"] as! Int
        self.TestNum = dict["testnum"] as! Int
        self.ProbNum = dict["probnum"] as! Int
    
        
        self.keyword_String = dict["keyword"] as? String ?? ""
        self.content1_String = dict["content1"] as? String ?? ""
        self.content2_String = dict["content2"] as? String ?? ""
        
        
    }
    
    func setToAttr(from str:String)->NSAttributedString{
        
        let result = NSMutableAttributedString()
        result.append(stringToAttrStringInHTML(str))
        result.addAttribute(NSAttributedStringKey.font, value: UIFont.solutionFont, range: NSRange(location: 0, length: result.length))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = SolLineSpace
        result.addAttributes([NSAttributedStringKey.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
        
        return result
        
    }
    
    func setToAttrWithImage(from str:String)->NSAttributedString{
        
        let result = replaceTagToImage(withString: str, imgName: "sol_\(ProbID)")
        result.addAttribute(NSAttributedStringKey.font, value: UIFont.solutionFont, range: NSRange(location: 0, length: result.length))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = SolLineSpace
        result.addAttributes([NSAttributedStringKey.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
        
        
        return result

        
    }
    
    
    func replaceTagToImage(withString str:String, imgName name:String, withWidth width:CGFloat = SCREEN_WIDTH - 20)->NSMutableAttributedString{
        
        let result = NSMutableAttributedString()
        
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "png"){
            
            let attachIcon:NSTextAttachment = NSTextAttachment()
            attachIcon.image = UIImage(contentsOfFile: bundlePath)
            let scaleFactor = attachIcon.image!.size.width / (width)
            attachIcon.image = UIImage(cgImage: attachIcon.image!.cgImage!, scale: scaleFactor, orientation: UIImageOrientation.up)
            let imageString = NSAttributedString(attachment: attachIcon)
            result.append(imageString)
            result.append(NSAttributedString(string: "\n"))
            
        }
        
        result.append(stringToAttrStringInHTML(str))
        return result
        
    }
    
}

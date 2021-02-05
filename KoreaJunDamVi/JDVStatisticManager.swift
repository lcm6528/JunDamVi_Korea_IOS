//
//  JDVStatisticManager.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2020/07/22.
//  Copyright © 2020 JunDamVi. All rights reserved.
//

import Foundation
import UIKit

class JDVStatisticManager {
    static let shared = JDVStatisticManager()
    
    var data: CommentData? = nil
    
    init() {
        ClientLogger.log(log: "JDVStatisticManager init")
        
        if let url = Bundle.main.url(forResource: "AnalDatabase", withExtension: "plist") {
            do {
                let data = try Data.init(contentsOf: url, options: .mappedIfSafe)
                let decoder = PropertyListDecoder()
                self.data = try decoder.decode(CommentData.self, from: data)
                ClientLogger.log(log: "load comment complete")
            } catch {
                ClientLogger.log(log: "load comment error : \(error.localizedDescription)")
            }
        }
    }
    
    func getTop3Info(type: SortedOption) -> [String] {
        switch type {
        case .time:
            return ["조선(24%)","일제강점기(14%)","근대 조선(13%)"]
        case .type:
            return ["해석(31%)","암기(20%)","테마(19%)"]
        case .theme:
            return ["사건(22%)","문화(15%)","제도(12%)"]
        default:
            return []
        }
    }
    
    
    func getAnalData(type: SortedOption) -> [CommentItem] {
        guard let data = self.data else { return [] }
        return data.getData(type: type)
    }
}

struct CommentItem: Decodable {
    var title: String
    var content: String
    var frequency: Float
    
    var contentAttr: NSMutableAttributedString {
        let result = NSMutableAttributedString(string: content.replacingOccurrences(of: "\\n", with: "\n"))
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ProbLineSpace
        result.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
        result.addAttribute(NSAttributedString.Key.font, value: UIFont.ProbNaviBarTitleFont, range: NSRange(location: 0, length: result.length))
        return result
    }
}

struct CommentData: Decodable {
    var theme: [CommentItem]
    var time: [CommentItem]
    var type: [CommentItem]
    
    func getData(type: SortedOption) -> [CommentItem] {
        switch type {
        case .time:
            return self.time
        case .type:
            return self.type
        case .theme:
            return self.theme
        default:
            return []
        }
    }
}

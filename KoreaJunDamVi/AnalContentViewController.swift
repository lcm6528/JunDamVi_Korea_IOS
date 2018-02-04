//
//  JDVAnalContentViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 3..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class JDVAnalContentViewController: UIViewController,IndicatorInfoProvider {
    var content:String!
    var itemInfo: IndicatorInfo = "View"
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO : Modeling
        let result = NSMutableAttributedString(string: content)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ProbLineSpace
        result.addAttributes([NSAttributedStringKey.paragraphStyle : style], range: NSRange(location: 0, length: result.length))
        result.addAttribute(NSAttributedStringKey.font, value: UIFont.ProbNaviBarTitleFont, range: NSRange(location: 0, length: result.length))
        
        contentTextView.attributedText = result
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

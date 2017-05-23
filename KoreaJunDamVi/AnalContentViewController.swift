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
    
    var itemInfo: IndicatorInfo = "View"
    
    
    @IBOutlet var contentTextView: UITextView!
    var content:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO : Modeling
        let result = NSMutableAttributedString(string: content)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ProbLineSpace
        result.addAttributes([NSParagraphStyleAttributeName : style], range: NSRange(location: 0, length: result.length))
        result.addAttribute(NSFontAttributeName, value: UIFont.ProbNaviBarTitleFont, range: NSRange(location: 0, length: result.length))
        
        
        contentTextView.attributedText = result
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    
}

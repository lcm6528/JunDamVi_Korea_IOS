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
        contentTextView.text = content
        
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

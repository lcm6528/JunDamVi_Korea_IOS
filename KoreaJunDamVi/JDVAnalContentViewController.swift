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
  
  @IBOutlet var graph: JDVGraph!
  @IBOutlet var contentTextView: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let model = JDVGraphModel(arrayLiteral: [("국가",3),("왕",21),("사건",4),("제도",5),("경제",8),("사회",25),("문화",5),("인물",2),("단체",6),("유물",4),("복합",11),("기타",6)])
    graph.setData(model: model)
    graph.setHighlight(toStanding: 3)
    
    contentTextView.text = "분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역분석자료 내용 영역"
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        graph.animate(withDuration: 1)
  }
  
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return itemInfo
  }
  
  
  
}

//
//  JDVPagerTestViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 30..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class JDVPagerTestViewController: ButtonBarPagerTabStripViewController {
  
  
  
  override func viewDidAppear(_ animated: Bool) {
    let selectedBarHeight: CGFloat = 2
    
    buttonBarView.selectedBar.frame.origin.y = buttonBarView.frame.size.height - selectedBarHeight
    buttonBarView.selectedBar.frame.size.height = selectedBarHeight
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buttonBarView.dataSource = self
    buttonBarView.delegate = self
    
    buttonBarView.selectedBar.backgroundColor = UIColor.black
    buttonBarView.backgroundColor = UIColor.white
    
    settings.style.buttonBarItemTitleColor = UIColor.black
    // Do any additional setup after loading the view.
  }
  
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
    let model = ["국가","왕","사건","제도","경제","사회","문화","인물","단체","유물","복합","기타"]
    var arr:[ChildExampleViewController] = []
    
    for title in model{
      let child = ChildExampleViewController(itemInfo: IndicatorInfo(title: title))
      arr.append(child)
    }
        return arr
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

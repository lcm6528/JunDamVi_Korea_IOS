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
    
    buttonBarView.selectedBar.backgroundColor = UIColor.black
    
    settings.style.buttonBarBackgroundColor = UIColor.white
    settings.style.buttonBarItemTitleColor = UIColor.blue
    settings.style.buttonBarLeftContentInset =  0
    settings.style.buttonBarRightContentInset = 0
    settings.style.buttonBarItemBackgroundColor = UIColor.white
    self.pagerBehaviour = PagerTabStripBehaviour.progressive(skipIntermediateViewControllers: true, elasticIndicatorLimit: true)
    
    super.viewDidLoad()
    
    
    changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
      guard changeCurrentIndex == true else { return }
      
      oldCell?.label.textColor = UIColor(white: 0, alpha: 0.6)
      newCell?.label.textColor = UIColor.black
      
      if animated {
        
        UIView.animate(withDuration: 0.1, animations: {
          newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
      }
      else {
        newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      }
    }
    
  }
  
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
    let model = ["국가","왕","사건","제도","경제","사회","문화","인물","단체","유물","복합","기타"]
    
    let storyboard = UIStoryboard(name: "Solution", bundle: nil)
    
    var arr:[JDVAnalContentViewController] = [JDVAnalContentViewController]()
    
    for title in model{
      let child = storyboard.instantiateViewController(withIdentifier: "JDVAnalContentViewController") as! JDVAnalContentViewController
      child.itemInfo =  IndicatorInfo(title: title)
      arr.append(child)
    }
    return arr
    
    
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

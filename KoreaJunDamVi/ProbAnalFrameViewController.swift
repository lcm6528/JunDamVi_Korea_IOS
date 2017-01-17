//
//  JDVProbAnalFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 10..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import PageMenu
class JDVProbAnalFrameViewController: JDVViewController {
  
  var pageMenu : CAPSPageMenu?
  let data = [("국가",3),("왕",21),("사건",4),("제도",5),("경제",8),("사회",25),("문화",5),("인물",2),("단체",6),("유물",4),("복합",11),("기타",6)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var controllerArray : [UIViewController] = []
    
    for (_,element) in data.enumerated(){
      let controller = self.storyboard?.instantiateViewController(withIdentifier: "JDVAnalContentViewController") as! JDVAnalContentViewController
      controller.title = element.0
      controllerArray.append(controller)
    }

    let parameters: [CAPSPageMenuOption] = [
      .viewBackgroundColor(UIColor.clear),
      .scrollMenuBackgroundColor(UIColor.white),
      .menuItemWidthBasedOnTitleTextWidth(true),
      .addBottomMenuHairline(true),
      .selectionIndicatorColor(UIColor.black),
      .selectedMenuItemLabelColor(UIColor.black),
      .selectionIndicatorHeight(2.0),
      .menuHeight(40.0),
      .menuItemMargin(10.0)
    ]
    
    
    pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:0.0, width:self.view.frame.width, height:self.view.frame.height), pageMenuOptions: parameters)
    
    
    self.view.addSubview(pageMenu!.view)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

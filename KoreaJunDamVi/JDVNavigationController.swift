//
//  JBVNavitionController.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 2. 18..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

class JDVNavigationController: UINavigationController,UINavigationControllerDelegate{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.tintColor = UIColor.white
    self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationBar.shadowImage = UIImage()
    
    
    // Do any additional setup after loading the view.
  }//59 128 126
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}

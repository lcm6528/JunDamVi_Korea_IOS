//
//  ViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var roundView: RoundView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    roundView.currentValue = 50
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


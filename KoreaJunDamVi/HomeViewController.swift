//
//  ViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController {

  @IBOutlet var roundView1: RoundView!

  @IBOutlet var centerContainerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    self.title = "한국사 전담비"
    
  }
  override func viewWillAppear(_ animated: Bool) {
    roundView1.currentValue = 70
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func settingButtonPressed(_ sender: AnyObject) {
    
    performSegue(withIdentifier: "settings", sender: self)
    
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case "settings":
//      let vc = segue.destination as! SettingsViewController
//      vc.hidesBottomBarWhenPushed = true
      self.tabBarController?.tabBar.isHidden = true
    default :
      return
    }
    
  }
}


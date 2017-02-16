//
//  ProbQuickTestViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 22..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbQuickTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func resultButtonPressed(_ sender: AnyObject) {
    performSegue(withIdentifier: "push", sender: self)
  }
  
  

}


extension ProbQuickTestViewController:UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }
  
  
}

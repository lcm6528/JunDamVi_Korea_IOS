//
//  JDVSolutionMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 27..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class JDVSolutionMenuViewController: UIViewController {
  
  @IBOutlet var graph: JDVGraph!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
    let model = JDVGraphModel(arrayLiteral: [("row1",3),("row2",13),("row3",12),("row4",14),("row5",19),("row6",16),("row7",13),("row8",11)])
    graph.setData(model: model)
    graph.setHighlight(toStanding: 3)
    
   
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    graph.animate(withDuration: 1)
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

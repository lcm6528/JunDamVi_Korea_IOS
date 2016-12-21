//
//  ProbResultViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

protocol ProbResultSubViewDelegate {
  func changeView()
}

class ProbResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ProbResultSubViewDelegate {
  
  
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  var heightOfSubView:CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    heightOfSubView = self.view.frame.size.height-getHeightOfStatusNNaviBar(self)
    let topView = ProbResultTopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: heightOfSubView))
    topView.delegate = self
    
    let botView = ProbResultBotView(frame: CGRect(x: 0, y: heightOfSubView, width: SCREEN_WIDTH, height: heightOfSubView))
    botView.delegate = self
    botView.tableView.delegate = self
    botView.tableView.dataSource = self
    
    contentView.addSubview(topView)
    contentView.addSubview(botView)
    
    
    
    
    
  }
  
  

  
  func changeView(){
    
    let offsetY:CGFloat = scrollView.contentOffset.y == 0.0 ? heightOfSubView : 0.0
    
    scrollView.setContentOffset(CGPoint(x: 0, y: offsetY) , animated: true)
    
    
  }
  
  
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 20
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
  
    let cell:ProbResultBotCell? = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProbResultBotCell
//    cell?.noteButton.addTarget(self, action: #selector(buttonPressed(_:)) , for: .touchUpInside)
    //custom for cell
  
    return cell!

   
  }
  func buttonPressed(_ sender:UIButton){
    sender.isSelected = true
    
  }
  
  
}

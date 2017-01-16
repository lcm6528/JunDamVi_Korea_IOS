//
//  JDVSolutionMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 27..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
class JDVSolutionMenuViewController: UIViewController {
  
  
  @IBOutlet var collectionView: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
//    let model = JDVGraphModel(arrayLiteral: [("국가",3),("왕",21),("사건",4),("제도",5),("경제",8),("사회",25),("문화",5),("인물",2),("단체",6),("유물",4),("복합",11),("기타",6)])

    
   
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
//    graph.animate(withDuration: 1)
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



extension JDVSolutionMenuViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 14
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if SCREEN_WIDTH > 430{
      return CGSize(width: 120, height: 120)
    }else{
      let length = SCREEN_WIDTH/3 - 20
      return CGSize(width: length, height: length)
    }
    
    
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    WSProgressHUD.show(withStatus: "해설 불러오는 중..")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    self.performSegue(withIdentifier: "push", sender: self)  
      
    }

    
  }
  
}

//
//  JDVSolutionMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 27..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
class JDVSolutionMenuViewController: JDVViewController {
    
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleWithStyle("문제 해설")
        
        
        let blockView =  BlockView(frame: self.view.frame)
        blockView.actionHandler = {
            blockView.removeFromSuperview()
        }
        self.view.addSubview(blockView)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
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

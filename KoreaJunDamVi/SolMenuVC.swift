//
//  JDVSolutionMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 27..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import WSProgressHUD
import SwiftyStoreKit
class JDVSolutionMenuViewController: JDVViewController {
    
    
    var dataArray:[String] = []
    
    var Probs:[Prob] = []
    var Solvs:[Solution] = []
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleWithStyle("문제 해설")
        
        
        let blockView =  BlockView(frame: self.view.frame)
        blockView.actionHandler = {
//            blockView.removeFromSuperview()
            
            SwiftyStoreKit.retrieveProductsInfo(["koreasolutions"]) { result in
                if let product = result.retrievedProducts.first {
                    let priceString = product.localizedPrice!
                    print("Product: \(product.localizedDescription), price: \(priceString)")
                }
                else if let invalidProductId = result.invalidProductIDs.first {
                    
                    showAlertWithString("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)", sender: self)
                    return
                }
                else {
                    print("Error: \(result.error)")
                }
            }
        }
        self.view.addSubview(blockView)
        
        
        fetchList()
    }
    
    func fetchList(){
        
        var dict:NSDictionary!
        let path = Bundle.main.path(forResource: "SolList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        do {
            let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            dict = object as! NSDictionary
        } catch {}
        
        
        dataArray = dict["solnum"] as! [String]
        self.collectionView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = true
        
        let vc = segue.destination as! JDVSolutionFrameViewController
        vc.Probs = self.Probs
        vc.Solvs = self.Solvs
    }
    
    
}



extension JDVSolutionMenuViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SolMenuCell
        
        
        let title = NSMutableAttributedString(string: "\(dataArray[indexPath.row])회")
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 30)! ], range: NSRange(location: 0,length: 2))
        title.addAttributes([NSFontAttributeName : UIFont(name: "NanumBarunGothic", size: 18)! ], range: NSRange(location: 2,length: 1))
        
        cell.titleLabel.attributedText = title
        
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
        isBlockUserInteract = true
        WSProgressHUD.show(withStatus: "해설 불러오는 중..")
        
        self.Probs = JDVProbManager.fetchProbs(withTestnum: dataArray[indexPath.row].toInt()!)
        self.Solvs = JDVSolutionManager.fetchSols(withTestnum: dataArray[indexPath.row].toInt()!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "push", sender: self)  
            
        }
        
        
    }
    
}

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
import Toaster
class JDVSolutionMenuViewController: JDVViewController {
    
    
    var dataArray:[String] = []
    
    var Probs:[Prob] = []
    var Solvs:[Solution] = []
    let blockView =  BlockView()
    
    var isPurchased:Bool = false{
        didSet{
            self.blockView.isHidden = self.isPurchased
        }
    }
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrive()
        
        self.setTitleWithStyle("문제 해설")
        blockView.frame = self.view.frame
        blockView.actionHandler = { index in
            switch index {
            case 0:
                self.purchase()
            case 1:
                self.preview()
            default:
                print("error in blockView Handler")
            }
            
        }
        
        
        self.view.addSubview(blockView)
        self.isPurchased = JDVProductManager.isPurchased()
        
        fetchList()
        
    }
    
    func purchase() {
        SwiftyStoreKit.purchaseProduct(ProductID, atomically: true) { result in
            switch result {
            case .success:
                Toast(text: "구매 성공!").show()
                setUserDefaultWithBool(true, forKey: ProductID)
                self.isPurchased = true
                
            case .error(let error):
                Toast(text: "결제 중 오류가 발생했습니다.").show()
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                default:
                    print("supererror")
                }
            }
        }
    }
    
    
    
    func preview() {
        
        isBlockUserInteract = true
        WSProgressHUD.show(withStatus: "해설 불러오는 중..")
        
        
        self.Probs = JDVProbManager.fetchProbs(withTestnum: dataArray[0].toInt()!)
        self.Solvs = JDVSolutionManager.fetchSols(withTestnum: dataArray[0].toInt()!)
        
        self.performSegue(withIdentifier: "push", sender: self)
        
        
    }
    func retrive() {
        
        SwiftyStoreKit.retrieveProductsInfo([ProductID]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }else {
                print("Error: \(result.error.debugDescription)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.isPurchased = JDVProductManager.isPurchased()
        
    }
    
    
    func fetchList() {
        
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
        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 30)! ], range: NSRange(location: 0,length: 2))
        title.addAttributes([NSAttributedStringKey.font : UIFont(name: "NanumBarunGothic", size: 18)! ], range: NSRange(location: 2,length: 1))
        
        cell.titleLabel.attributedText = title
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if SCREEN_WIDTH > 430{
            return CGSize(width: 120, height: 120)
        } else {
            let length = SCREEN_WIDTH/3 - 20
            return CGSize(width: length, height: length)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isPurchased == true else{ return }
        isBlockUserInteract = true
        WSProgressHUD.show(withStatus: "해설 불러오는 중..")
        
        self.Probs = JDVProbManager.fetchProbs(withTestnum: dataArray[indexPath.row].toInt()!)
        self.Solvs = JDVSolutionManager.fetchSols(withTestnum: dataArray[indexPath.row].toInt()!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue(withIdentifier: "push", sender: self)
            
        }
        
    }
    
}

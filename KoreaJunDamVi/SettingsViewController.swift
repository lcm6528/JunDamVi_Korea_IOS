//
//  SettingsViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 23..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI
import Toaster
import SwiftyStoreKit
class SettingsViewController: JDVViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setTitleWithStyle("설정")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTableViewCell
        
        if indexPath.row == 0{
         
            cell.contentImageView.image = UIImage(named: "reset")
            cell.contentTitleLabel.text = "학습내역 초기화"
            cell.contentSubtitleLabel.text = "학습내역을 초기화하면 앱 내 모든 정보가 초기화됩니다."
            
            
        }else if indexPath.row == 1{
            cell.contentImageView.image = UIImage(named: "restore")
            cell.contentTitleLabel.text = "구매내역 복원"
            cell.contentSubtitleLabel.text = "해설 구매내역을 복원합니다."
            
            
            
        }else if indexPath.row == 2{
            cell.contentImageView.image = UIImage(named: "mail")
            cell.contentTitleLabel.text = "문의 및 제안"
            cell.contentSubtitleLabel.text = "jundamvi@gmail.com 으로 의견을 보내주세요!"
            
            
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            ShowResetAlert()
            
        }else if indexPath.row == 1{
            RestoreProduct()
            //restore
        }else if indexPath.row == 2{
            
            ShowMail()
        }
        
    }
    
    
    func ShowMail(){
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        var mailFooter = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n -------------------\n\n"
        mailFooter += "Korea History JUNDAMVI \n\nFeedBack Information\n\n"
        mailFooter += UIDevice.current.modelName + "\n\n"
        mailFooter += "IOS " + UIDevice.current.systemVersion + "\n\n"
        mailFooter += "AppVersion " + appVersion
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["jundamvi@gmail.com"])
        mailComposerVC.setSubject("[IOS] FeedBack for App")
        mailComposerVC.setMessageBody(mailFooter, isHTML: false)
        
        
        return mailComposerVC
    }

    
    
    func ShowResetAlert(){
        let alert = UIAlertController(title: "학습내역 초기화", message: "앱 내 모든 정보가 초기화됩니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler:
            { action in
                
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
                
                let appDomain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
                
                let isPurchased = JDVProductManager.isPurchased()
                setUserDefaultWithBool(isPurchased, forKey: ProductID)
                
                Toast(text: "학습내역 초기화 완료").show()
                
                
        }))
        
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler:
            { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func RestoreProduct(){
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedProducts.count > 0 {
                print("Restore Failed: \(results.restoreFailedProducts)")
                showAlertWithString("복원 실패", message: "구매내역 복원에 실패하였습니다.", sender: self)
            }
            else if results.restoredProducts.count > 0 {
                showAlertWithString("복원 완료", message: "구매내역을 복원하였습니다.", sender: self)
                setUserDefaultWithBool(true, forKey: ProductID)
            }
            else {
                showAlertWithString("복원 완료", message: "구매내역을 복원하였습니다.", sender: self)
            }
        }
    }
    
    
    
    // MARK: MFMailComposeViewControllerDelegate Method
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: NSError?) {
        controller.dismiss(animated: true)
    }
    
}

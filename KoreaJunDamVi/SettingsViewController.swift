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
class SettingsViewController: JDVViewController {
    
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var models = [SettingsViewCellModel(withOption: SettingsOption.reset),
                  SettingsViewCellModel(withOption: SettingsOption.restore),
                  SettingsViewCellModel(withOption: SettingsOption.mail)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "Ver \(MNVersion.currentVersion)"
        self.setTitleWithStyle("설정")
        
        models[0].handler = ShowResetAlert
        models[1].handler = ShowRestoreAlert
        models[2].handler = ShowMail
        
    }
    
}

extension SettingsViewController: MFMailComposeViewControllerDelegate{
    
    func ShowMail(){
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let appVersion = MNVersion.currentVersion
        let mailFooter = """
        \n\n\n\n\n\n\n\n\n\n\n\n\n\n -------------------\n\n
        Korea History JUNDAMVI \n\nFeedBack Information\n\n
        \(UIDevice.current.modelName) \n\n
        IOS \(UIDevice.current.systemVersion) \n\n
        AppVersion \(appVersion)
        """
        
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
    
    func ShowRestoreAlert(){
        
        let alert = UIAlertController(title: "구매내역 복원", message: "앱스토어 구매내역을 복원합니다.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler:
            { action in
                
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
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler:
            { action in}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
        
        controller.dismiss(animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTableViewCell
        cell.configure(model: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        models[indexPath.row].handler()
    }
}

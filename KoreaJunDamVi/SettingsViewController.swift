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
                  SettingsViewCellModel(withOption: SettingsOption.mail),
                  SettingsViewCellModel(withOption: SettingsOption.autonext),
                  SettingsViewCellModel(withOption: SettingsOption.showprob)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "Ver \(MNVersion.currentVersion)"
        self.setTitleWithStyle("설정")
        
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.lineBlack
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func ShowMail() {
        
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
    
    func ShowResetAlert() {
        
        let alert = UIAlertController(title: "학습내역 초기화", message: "앱 내 모든 정보가 초기화됩니다.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.destructive, handler:
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
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler:
            { action in}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func ShowRestoreAlert() {
        let alert = UIAlertController(title: "구매내역 복원", message: "앱스토어 구매내역을 복원합니다.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler:
            { action in
                
                SwiftyStoreKit.restorePurchases(atomically: true) { results in
                    if results.restoreFailedPurchases.count > 0 {
                        print("Restore Failed: \(results.restoreFailedPurchases)")
                        showAlertWithString("복원 실패", message: "구매내역 복원에 실패하였습니다.", sender: self)
                    }
                    else if results.restoredPurchases.count > 0 {
                        showAlertWithString("복원 완료", message: "구매내역을 복원하였습니다.", sender: self)
                        setUserDefaultWithBool(true, forKey: ProductID)
                    }
                    else {
                        showAlertWithString("복원 완료", message: "구매내역을 복원하였습니다.", sender: self)
                    }
                }
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler:
            { action in}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @objc func toggleSwitch(_ sender: UISwitch) {
        let isOn = sender.isOn
        let key = sender.tag == 1 ? kAutoNextKey : kShowProbKey
        setUserDefaultWithBool(isOn, forKey: key)
        
        if sender.tag == 1 && isOn {
            setUserDefaultWithBool(false, forKey: kShowProbKey)
            tableView.reloadData()
        }
        
        if sender.tag == 2 && isOn {
            setUserDefaultWithBool(false, forKey: kAutoNextKey)
            tableView.reloadData()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTableViewCell
        let item = models[indexPath.row]
        cell.configure(model: item)
        
        if item.option == .autonext {
            let lightSwitch = UISwitch(frame: .zero)
            lightSwitch.isOn = getUserDefaultBoolValue(kAutoNextKey)
            lightSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .valueChanged)
            lightSwitch.tag = 1
            cell.accessoryView = lightSwitch
        } else if item.option == .showprob {
            let lightSwitch = UISwitch(frame: .zero)
            lightSwitch.isOn = getUserDefaultBoolValue(kShowProbKey)
            lightSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .valueChanged)
            lightSwitch.tag = 2
            cell.accessoryView = lightSwitch
        } else {
            cell.accessoryView = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = models[indexPath.row]
        switch item.option {
        case .mail:
            ShowMail()
        case .reset:
            ShowResetAlert()
        case .restore:
            ShowRestoreAlert()
        default:
            break
        }
    }
}

//
//  ViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import SwiftyJSON
class HomeViewController: JDVViewController {
    
    @IBOutlet var roundView1: RoundView!
    @IBOutlet var centerContainerView: UIView!
    @IBOutlet var label_MidView: UILabel!
    @IBOutlet var ddayTitleLabel: UILabel!
    @IBOutlet var ddayCotentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet weak var applyButton: JDVButton!
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var dateStringLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var printLabel: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var cancel50Label: UILabel!
    
    
    var Tests:[String] = []
    var completeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle("한국사 비법노트")
        self.centerContainerView.layer.cornerRadius = 5.0
        self.applyButton.layer.cornerRadius = 3
        self.dateLabel.layer.cornerRadius = 10
        self.dateLabel.text = "  시험일정 업데이트 예정입니다.  "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchList()
        setDday()
        label_MidView.attributedText = getAttrStr(totalValue: Tests.count , withValue: completeCount)
        
        roundView1.setValue(value: CGFloat(completeCount)/CGFloat(Tests.count)*100, animate: false)
    }
  
    func fetchList() {
        var dict:NSDictionary!
        let path = Bundle.main.path(forResource: "ProbList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        do {
            let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            dict = object as! NSDictionary
        } catch {}
        
        Tests = dict.value(forKey: SortedOption.test.rawValue) as! [String]
        completeCount = 0
        
        for test in Tests {
            if let arr = JDVProbManager.getCachedData(with: test) {
                if arr.isEmpty == true {
                    completeCount += 1
                }
            }
        }
    }
    
    func setDday() {
        let jsondata = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "testday", ofType: "json")!))
        let json = try! JSON(data:jsondata)["data"]
        let arr = json.arrayObject as! [[String: String]]
        
        for item in arr {
            let test = item["num"]!
            let date = Date(dateString: item["day"]!)
            let now = Date()
            if date < now { continue }
            else if date > now {
                setInfo(data: item)
                break
            }
        }
    }
    
    func setInfo(data: [String : String]) {
        guard let test = data["num"] else { return }
        guard let day = data["day"] else { return }
        guard let apply = data["apply"]  else { return }
        guard let bonus = data["bonus"] else { return }
        guard let date = data["date"] else { return }
        guard let result = data["result"] else { return }
        guard let change = data["change"] else { return }
        guard let photo = data["photo"] else { return }
        guard let print = data["print"] else { return }
        guard let cancel100 = data["cancel100"] else { return }
        guard let cancel50 = data["cancel50"] else { return }
        
        let dateObject = Date(dateString: day)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        
        let dday = dateObject.daysFromNow()
        ddayTitleLabel.text = "\(test)회 한국사능력검정시험"
        ddayCotentLabel.text = "D\(dday)"
        dateLabel.text = formatter.string(from: dateObject)
        numLabel.text = test
        startLabel.text = apply
        endLabel.text = bonus
        dateStringLabel.text = date
        resultLabel.text = result
        changeLabel.text = change
        photoLabel.text = photo
        printLabel.text = print
        cancelLabel.text = cancel100
        cancel50Label.text = cancel50
    }
    
    func getAttrStr(totalValue total: Int, withValue value: Int)->NSMutableAttributedString {
        let font1 = UIFont(name: "NanumBarunGothic", size: 15)!
        let font2 = UIFont(name: "NanumBarunGothicUltraLight", size: 15)!
        let str1 = NSMutableAttributedString(string: "총 \(total)개")
        let str2 = NSMutableAttributedString(string: "의 기출 문제 중 ")
        let str3 = NSMutableAttributedString(string: "\(value)개 ")
        let str4 = NSMutableAttributedString(string: "풀이 진행")
        
        str1.addAttributes([NSAttributedString.Key.font: font1, NSAttributedString.Key.foregroundColor: UIColor.textBlack75], range: NSRange(location: 0, length: str1.length))
        str2.addAttributes([NSAttributedString.Key.font: font2, NSAttributedString.Key.foregroundColor: UIColor.textBlack50], range: NSRange(location: 0, length: str2.length))
        str3.addAttributes([NSAttributedString.Key.font: font1, NSAttributedString.Key.foregroundColor: UIColor.untPaleRed], range: NSRange(location: 0, length: str3.length))
        str4.addAttributes([NSAttributedString.Key.font: font2, NSAttributedString.Key.foregroundColor: UIColor.textBlack50], range: NSRange(location: 0, length: str4.length))
        
        let str = NSMutableAttributedString()
        str.append(str1)
        str.append(str2)
        str.append(str3)
        str.append(str4)
        return str
    }
    
    @IBAction func settingButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        showAlertWithSelect("접수하러가기", message: "한국사능력검정시험 사이트로\n이동합니다.", sender: self, handler: { (_) in
            if let url = URL(string: "http://www.historyexam.go.kr/main/mainPage.do") {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "settings":
            self.tabBarController?.tabBar.isHidden = true
        default :
            return
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

//
//  ViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 24..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
class HomeViewController: JDVViewController {
    
    @IBOutlet var roundView1: RoundView!
    
    @IBOutlet var centerContainerView: UIView!
    
    @IBOutlet var label_MidView: UILabel!
    
    var Tests:[String] = []
    var completeCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle("한국사 전담비")
    }
    
    
    
    func fetchList(){
        
        var dict:NSDictionary!
        let path = Bundle.main.path(forResource: "ProbList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        do {
            let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            dict = object as! NSDictionary
        } catch {}
        
        Tests = dict.value(forKey: "회차별") as!  [String]
        
        completeCount = 0
        
        for test in Tests{
            if let arr = JDVProbManager.getCachedData(with: test){
                if arr.isEmpty == true{
                    completeCount += 1
                }
                
            }
        }
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchList()
        label_MidView.attributedText = getAttrStr(totalValue: Tests.count , withValue: completeCount)
        
        roundView1.setValue(value: CGFloat(completeCount/Tests.count)*100, animate: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    func getAttrStr(totalValue total:Int,withValue value:Int)->NSMutableAttributedString{
        
        let font1 = UIFont(name: "NanumBarunGothic", size: 15)!
        let font2 = UIFont(name: "NanumBarunGothicUltraLight", size: 15)!
        
        
        let str1 = NSMutableAttributedString(string: "총 \(total)개")
        let str2 = NSMutableAttributedString(string: "의 기출 문제 중 ")
        let str3 = NSMutableAttributedString(string: "\(value)개 ")
        let str4 = NSMutableAttributedString(string: "풀이 진행")
        
        str1.addAttributes([NSFontAttributeName: font1, NSForegroundColorAttributeName: UIColor.untBlack757575], range: NSRange(location: 0, length: str1.length) )
        str2.addAttributes([NSFontAttributeName: font2, NSForegroundColorAttributeName: UIColor.untBlack505050], range: NSRange(location: 0, length: str2.length) )
        str3.addAttributes([NSFontAttributeName: font1, NSForegroundColorAttributeName: UIColor.untPaleRed], range: NSRange(location: 0, length: str3.length) )
        str4.addAttributes([NSFontAttributeName: font2, NSForegroundColorAttributeName: UIColor.untBlack505050], range: NSRange(location: 0, length: str4.length) )
        
        
        
        let str = NSMutableAttributedString()
        str.append(str1)
        str.append(str2)
        str.append(str3)
        str.append(str4)
        return str
        
    }
    
    //  let attStr = NSMutableAttributedString(string: "\(value)%")
    //  attStr.addAttributes([NSFontAttributeName: UIFont(name: "NanumBarunGothicLight", size: 36)!], range: NSRange(location: 0, length: attStr.length-1) )
    //  attStr.addAttributes([NSFontAttributeName: UIFont(name: "NanumBarunGothicLight", size: 22)!], range: NSRange(location: attStr.length-1, length: 1) )
    //  return attStr
    //
    
    
    
    
    @IBAction func settingButtonPressed(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "settings", sender: self)
        
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


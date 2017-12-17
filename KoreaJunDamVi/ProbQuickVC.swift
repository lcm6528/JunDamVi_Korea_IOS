//
//  ProbQuickTestViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 22..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//


//NOTE : Probs를 background에서 불러와서 저장하자. 뷰 넘어갈때 호출하니 빠른채점의 느낌이 나지 않음.

import UIKit
import RealmSwift
import WSProgressHUD
class ProbQuickTestViewController : JDVViewController {
    
    
    @IBOutlet var pushButton: JDVButton!
    @IBOutlet var tableView: UITableView!
    
    var option: JDVProbManager.ProbOption!
    
    var selections: [Int] = []
    var Probs: [QuickProb] = []
    var result: TestResult!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setTitleWithStyle("\(Probs[0].TestNum)회 빠른채점")
        selections = [Int](repeatElement(0, count: Probs.count))
        
        pushButton.layer.cornerRadius = 4
        pushButton.layer.borderWidth = 0.5
        pushButton.layer.borderColor = UIColor.gray.cgColor
        
        
        self.navigationController?.delegate = self
    }
    
    @IBAction func resultButtonPressed(_ sender: AnyObject) {
        WSProgressHUD.show(withStatus: "체점 중 ..")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.performSegue(withIdentifier: "push", sender: self)
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ProbResultViewController
        var tries:[Try] = []
        for (index, prob) in Probs.enumerated(){
            let item = Try(withQuickProb: prob, selection: selections[index])
            tries.append(item)
        }
        
        result = TestResult(withTestType: option.sortedOption.rawValue, forKey: option.cacheKey, withTries: tries)
        vc.result = self.result
        vc.option = option
        JDVScoreManager.configureAnalData(by: result)
        
        let record = TestResultRecord(by: result)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        
    }
}


extension ProbQuickTestViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProbQuickCell
        cell.probNum = indexPath.row
        cell.titleLabel.text = "\(indexPath.row+1)번"
        cell.manager?.selectButtonAtIndex(selections[indexPath.row]-1)
        cell.SelectionHandelr = { (probnum,selection) -> Void in
            self.selections[probnum] = selection
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Probs.count
    }
}


extension ProbQuickTestViewController : UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        WSProgressHUD.dismiss()
        isBlockUserInteract = false
        
    }
    
}



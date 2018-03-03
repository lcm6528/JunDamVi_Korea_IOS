//
//  ProbResultViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
import WSProgressHUD
protocol ProbResultSubViewDelegate {
    func changeView()
}

class ProbResultViewController: UIViewController, ProbResultSubViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    var option:JDVProbManager.ProbOption!
    var result:TestResult!
    var heightOfSubView:CGFloat!
    var addedNote = Set<Note>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "\(result.Tries[0].TestNum)회 문제 풀이 결과"
        heightOfSubView = self.view.frame.size.height - 64
        let realm = try! Realm()
        //        let trial = realm.objects(TestResultRecord.self).filter {return $0.TestKey == self.option.cacheKey}.count
        let trial = Array(realm.objects(TestResultRecord.self)).filter { return $0.TestKey == self.option.cacheKey }.count
        
        result.TryNum = trial
        //topView setup
        let topView = ProbResultTopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: heightOfSubView))
        topView.delegate = self
        topView.configure(result: result)
        
        //botView setup
        let botView = ProbResultBotView(frame: CGRect(x: 0, y: heightOfSubView, width: SCREEN_WIDTH, height: heightOfSubView))
        botView.delegate = self
        botView.tableView.delegate = self
        botView.tableView.dataSource = self
        botView.dismissHandler = {
            self.tabBarController?.selectedIndex = 3
            self.dismiss(animated: true, completion: nil)
        }
        
        contentView.addSubview(topView)
        contentView.addSubview(botView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSProgressHUD.dismiss()
        JDVProbManager.saveCachedData(with: option.cacheKey, tries: [])
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func changeView() {
        let offsetY:CGFloat = scrollView.contentOffset.y == 0.0 ? heightOfSubView : 0.0
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY) , animated: true)
    }
    
    @objc func buttonPressed(_ sender:UIButton) {
        
        let tryObj = result.Tries[sender.tag]
        let note = Note()
        note.ProbID = tryObj.ProbID
        note.Selection = tryObj.Selection
        
        if sender.isSelected == false{
            JDVNoteManager.saveNote(by: note)
        } else {
            JDVNoteManager.deleteNote(by: note)
        }
        sender.isSelected = !sender.isSelected
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.Tries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProbResultBotCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProbResultBotCell
        
        cell.configure(item: result.Tries[indexPath.row])
        cell.noteButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        cell.noteButton.tag = indexPath.row
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "testheader")
        let header = view as! testheader
        return header
    }
}

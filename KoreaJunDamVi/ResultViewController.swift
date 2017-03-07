//
//  ProbResultViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
protocol ProbResultSubViewDelegate {
    func changeView()
}

class ProbResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ProbResultSubViewDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    
    var result:TestResult!
    var heightOfSubView:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        try! realm.write {
                realm.deleteAll()
        }
        
        
        self.titleLabel.text = "\(result.Tries[0].TestNum)회 문제 풀이 결과"
        
        heightOfSubView = self.view.frame.size.height-64
        let topView = ProbResultTopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: heightOfSubView))
        topView.delegate = self
        topView.configure(result: result)
        
        let botView = ProbResultBotView(frame: CGRect(x: 0, y: heightOfSubView, width: SCREEN_WIDTH, height: heightOfSubView))
        botView.delegate = self
        botView.tableView.delegate = self
        botView.tableView.dataSource = self
        
        contentView.addSubview(topView)
        contentView.addSubview(botView)
        
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismissVC(completion: nil)
    }
    
    
    
    
    func changeView(){
        
        let offsetY:CGFloat = scrollView.contentOffset.y == 0.0 ? heightOfSubView : 0.0
        
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY) , animated: true)
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return result.Tries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell:ProbResultBotCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProbResultBotCell
        
        cell.configure(item: result.Tries[indexPath.row])
        cell.noteButton.addTarget(self, action: #selector(buttonPressed(_:)) , for: .touchUpInside)
        cell.noteButton.tag = indexPath.row
        
        //custom for cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "testheader")
        let header = view as! testheader
        return header
        
    }
    
    
    
    func buttonPressed(_ sender:UIButton){
        
        
        
        
        
        if sender.isSelected == false{
            
            let tryObj = result.Tries[sender.tag]
            let note = Note()
            note.ProbID = tryObj.ProbID
            note.Selection = tryObj.Selection
            
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(note)
            }
            
            
            
        }
        
        
        sender.isSelected = !sender.isSelected
        
        
        
        
    }
    
    
}

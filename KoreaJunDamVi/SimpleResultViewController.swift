//
//  SimpleResultViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 30..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import UICountingLabel
import WSProgressHUD
class SimpleResultViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var gageView: GageView!
    @IBOutlet var circleView: RoundView!
    @IBOutlet var label_right: UICountingLabel!
    @IBOutlet var label_wrong: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    var option:JDVProbManager.ProbOption!
    
    var result:TestResult!
    var heightOfSubView:CGFloat!
    
    var addedNote = Set<Note>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "testheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "testheader")
        tableView.register(UINib(nibName: "ProbResultBotCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismissVC(completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSProgressHUD.dismiss()
        JDVProbManager.saveCachedData(with: option.cacheKey, tries: [])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label_right.format = "%d"
        label_right.method = .easeIn
        label_right.animationDuration = 0.8
        label_right.countFromZero(to: CGFloat(result.numberOfRight))
        label_wrong.text = "\(result.numberOfWrong+result.numberOfPass)"
        
        gageView.currentValue = CGFloat((Float(result.numberOfRight)/Float(result.Tries.count)) * 100)
        
        let totalRate = Float(result.numberOfRight)/Float(result.Tries.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.circleView.setValue(value: CGFloat(totalRate*100), animate: true)
            
        }

        
        
        
    }
    
    

}



extension SimpleResultViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return result.Tries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell:ProbResultBotCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProbResultBotCell
        
        cell.configureForSimpleResult(item: result.Tries[indexPath.row])
        cell.noteButton.addTarget(self, action: #selector(buttonPressed(_:)) , for: .touchUpInside)
        cell.noteButton.tag = indexPath.row
        cell.selectionStyle = .none
        //custom for cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "testheader")
        let header = view as! testheader
        return header
        
    }
    
    func buttonPressed(_ sender:UIButton){
        
        
        let tryObj = result.Tries[sender.tag]
        let note = Note()
        note.ProbID = tryObj.ProbID
        note.Selection = tryObj.Selection
        
        if sender.isSelected == false{
            
            JDVNoteManager.saveNote(by: note)
            
        }else{
            JDVNoteManager.deleteNote(by: note)
        }
        
        sender.isSelected = !sender.isSelected
        
    }

    
    

    
    
}

//
//  JDVNoteMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 26..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class JDVNoteMenuViewController: JDVViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var probButton: JDVButton!
    
    var noteDatas: [ProbData] = []
    var option = JDVProbManager.ProbOption()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle("오답노트")
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.tableFooterView = UIView()
        
        option.sortedOption = .note
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        let realm = try! Realm()
        
        let result = realm.objects(Note.self)
        
        let notes = Array(result)
        var probs = JDVProbManager.fetchProbs(withProbID: notes.map{ $0.ProbID })
        
        if notes.count != probs.count {
            showAlertWithString("데이터 오류", message: "저장된 데이터가 손상되었습니다. 설정화면에서 학습내역 초기화를 통하여 해결할 수 있습니다.", sender: self)
            return
        }
        noteDatas.removeAll()
        for i in 0..<notes.count {
            probs[i].note = notes[i]
            noteDatas.append(probs[i])
        }
        
        self.probButton.isHidden = notes.count < 2
        self.tableView.reloadDataWithoutScroll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "pushinit":
            let vc = segue.destination as! ProbTestFrameViewController
            vc.probData = self.noteDatas
            vc.option = option
            self.tabBarController?.tabBar.isHidden = true
            
        case "push":
            let vc = segue.destination as! NoteFrameVC
            vc.noteDatas = noteDatas
            vc.initialIdx = sender as? Int ?? 0
            self.tabBarController?.tabBar.isHidden = true
        default :
            return
        }
    }
    
    @IBAction func probButtonPressed(_ sender: Any) {
        guard noteDatas.count != 0 else {
            showAlertWithString("오류", message: "오답노트를 추가해주세요!", sender: self)
            return
        }
        performSegue(withIdentifier: "pushinit", sender: nil)
    }
}


extension JDVNoteMenuViewController: UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JDVNoteMenuCell
        cell.configure(by: noteDatas[indexPath.row].prob)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteDatas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "push", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            JDVNoteManager.deleteNote(by: noteDatas[indexPath.row].note)
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "저장된 오답노트가 없습니다!", attributes: [NSAttributedString.Key.font:UIFont.EmptySetTitle])
    }
}

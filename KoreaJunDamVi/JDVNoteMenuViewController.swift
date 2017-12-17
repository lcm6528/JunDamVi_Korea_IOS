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

class JDVNoteMenuViewController: JDVViewController{
    
    @IBOutlet var tableView: UITableView!
    var Notes:[Note] = []
    
    var probs:[Prob] = []
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setTitleWithStyle("오답노트")
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.tableFooterView = UIView()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    func fetchNotes(){
        
        let realm = try! Realm()
        
        let result = realm.objects(Note.self)
        Notes = Array(result)
        
        probs = JDVProbManager.fetchProbs(withProbID: Notes.map{$0.ProbID})
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NoteInnerViewController
        vc.Prob = probs[currentIndex]
        vc.Solv = JDVSolutionManager.fetchSol(withProbID: probs[currentIndex].ProbID)
        vc.selection = Notes[currentIndex].Selection
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
}


extension JDVNoteMenuViewController: UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JDVNoteMenuCell
        cell.configure(by: probs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return probs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "push", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            JDVNoteManager.deleteNote(by: Notes[indexPath.row])
            fetchNotes()   
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "저장된 오답노트가 없습니다!", attributes: [NSAttributedStringKey.font:UIFont.EmptySetTitle])
    }
}

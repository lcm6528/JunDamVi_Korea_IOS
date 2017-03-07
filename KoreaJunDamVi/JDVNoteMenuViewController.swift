//
//  JDVNoteMenuViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 26..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
class JDVNoteMenuViewController: UIViewController{

    @IBOutlet var tableView: UITableView!
    var Notes:[Note] = []
    
    var probs:[Prob] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    func fetchNotes(){
       
        let realm = try! Realm()
        
        let result = realm.objects(Note.self)
        Notes = Array(result)
        
        probs = []
        for note in Notes{
            if let prob = JDVProbManager.fetchProb(withProbID: note.ProbID){
                probs.append(prob)
            }
        }
        
        self.tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension JDVNoteMenuViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JDVNoteMenuCell
    
    cell.configure(by: probs[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return probs.count
  }
  
  
  
}

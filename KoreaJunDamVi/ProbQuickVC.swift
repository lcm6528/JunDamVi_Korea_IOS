//
//  ProbQuickTestViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 22..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbQuickTestViewController: JDVViewController {
    
    
    var TestNum:Int!
    var selections:[Int] = []
    var Probs:[Prob] = []
    var result:TestResult!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for prob in Probs{
            print("\(prob.Answer)")
        }
        
        self.setTitleWithStyle("\(Probs[0].TestNum)회 빠른채점")
        selections = [Int](repeatElement(0, count: Probs.count))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resultButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "push", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProbResultViewController
        var tries:[Try] = []
        for (index, prob) in Probs.enumerated(){
            let item = Try(withProb: prob, selection: selections[index])
            tries.append(item)
        }
        result = TestResult(withTries: tries)
        vc.result = self.result

    }
    
    
}


extension ProbQuickTestViewController:UITableViewDataSource{
    
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
        return 50
    }
    
    
    
}

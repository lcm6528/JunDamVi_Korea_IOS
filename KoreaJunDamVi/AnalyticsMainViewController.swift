//
//  AnalyticsMainViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 17..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class AnalyticsMainViewController: JDVViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var recentView: AnalRoundView!
    @IBOutlet var highView: AnalRoundView!
    @IBOutlet var rowView: AnalRoundView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle("실력 분석")
        
    }
    
    func configureRoundViews(){
        let data = JDVScoreManager.AnalModel()
        
        guard data.recent.TestNum != 0 else{return}
        
        recentView.subTitle = "\(data.recent.TestNum)회"
        recentView.value = "\(data.recent.Score)"
        
        highView.subTitle = "\(data.high.TestNum)회"
        highView.value = "\(data.high.Score)"
        
        rowView.subTitle = "\(data.row.TestNum)회"
        rowView.value = "\(data.row.Score)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureRoundViews()
    }
}

extension AnalyticsMainViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnalContentCell
        cell.bar1.setValue(forRedBar: 10, BlackBar: 20, GrayBar: 30)
        cell.bar1.bottomLabel.text = "27회"
        cell.bar2.setValue(forRedBar: 40, BlackBar: 20, GrayBar: 30)
        cell.bar2.bottomLabel.text = "30회"
        cell.bar3.setValue(forRedBar: 20, BlackBar: 20, GrayBar: 60)
        cell.bar3.bottomLabel.text = "29회"
        cell.bar4.setValue(forRedBar: 60, BlackBar: 90, GrayBar: 30)
        cell.bar4.bottomLabel.text = "28회"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnalContentCell
        cell.setBarUI(withAnimate: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let celll = cell as! AnalContentCell
        celll.setBarUI(withAnimate: true)
    }
    
}

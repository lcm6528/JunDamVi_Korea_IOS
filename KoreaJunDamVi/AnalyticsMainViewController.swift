//
//  AnalyticsMainViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 17..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
class AnalyticsMainViewController: JDVViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var recentView: AnalRoundView!
    @IBOutlet var highView: AnalRoundView!
    @IBOutlet var rowView: AnalRoundView!
    
    var records:[TestResultRecord] = []
    
    
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecords()
        configureRoundViews()
    }
    
    
    
    func fetchRecords(){
        
        let realm = try! Realm()
        let result = realm.objects(TestResultRecord.self)
        records = Array(result)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! AnalContentCell
        cell.collectionView.reloadData()
    }
    
    
}
extension AnalyticsMainViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let record = records[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnalBarChartCell
        cell.configure(by: record)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chartcell = cell as! AnalBarChartCell
        chartcell.barChart.setBarUI(withAnimate: true)
        
    }
}



extension AnalyticsMainViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnalContentCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! AnalContentCell
        
    }
    
    
}

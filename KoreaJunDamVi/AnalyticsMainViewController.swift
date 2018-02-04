//
//  AnalyticsMainViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 17..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet
class AnalyticsMainViewController: JDVViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var recentView: AnalRoundView!
    @IBOutlet var highView: AnalRoundView!
    @IBOutlet var rowView: AnalRoundView!
    
    var records:[[TestResultRecord]] = []
    
    var keys:[JDVProbManager.SortedOption] = [.test,.time,.type,.theme]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleWithStyle("실력 분석")
        fetchRecords()
        
    }
    
    func configureRoundViews() {
        let data = JDVScoreManager.AnalModel()
        
        guard data.recent.TestNum != 0 else{
            recentView.subTitle = ""
            recentView.value = "-"
            
            highView.subTitle = ""
            highView.value = "-"
            
            rowView.subTitle = ""
            rowView.value = "-"
            return
        }
        
        recentView.subTitle = "\(data.recent.TestNum)회"
        recentView.value = "\(data.recent.Score)"
        
        highView.subTitle = "\(data.high.TestNum)회"
        highView.value = "\(data.high.Score)"
        
        rowView.subTitle = "\(data.row.TestNum)회"
        rowView.value = "\(data.row.Score)"
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecords()
        configureRoundViews()
    }
    
    
    
    func fetchRecords() {
        
        let realm = try! Realm()
        let result = realm.objects(TestResultRecord.self)
        records = []
        for option in keys{
            records.append(Array(result).filter{return ($0.TestType == option.rawValue)}.reversed())
        }
        
        
        
        tableView.reloadData()
        let cells = tableView.visibleCells as! [AnalContentCell]
        for cell in cells{
            cell.collectionView.reloadData()
        }
    }
    
    
}
extension AnalyticsMainViewController : UICollectionViewDataSource,UICollectionViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let record = records[collectionView.tag][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnalBarChartCell
        cell.configure(by: record)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return records[collectionView.tag].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chartcell = cell as! AnalBarChartCell
        chartcell.barChart.setBarUI(withAnimate: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "분석 데이터가 존재하지 않습니다.", attributes: [NSAttributedStringKey.font:UIFont.EmptySetTitle])
    }
}



extension AnalyticsMainViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AnalContentCell
        
        cell.label_title.text = keys[indexPath.row].description + " 점수"
        cell.collectionView.tag = indexPath.row
        cell.shadowView.layer.cornerRadius = 5
        
        cell.collectionView.emptyDataSetSource = self
        cell.collectionView.emptyDataSetDelegate = self
        
        cell.collectionView.reloadData()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! AnalContentCell
        
    }
    
    
}

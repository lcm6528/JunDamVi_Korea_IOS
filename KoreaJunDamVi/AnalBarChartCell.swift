//
//  AnalBarChartCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 15..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class AnalBarChartCell: UICollectionViewCell {
    
    @IBOutlet var barChart: AnalBarChartView!
    func configure(by record:TestResultRecord){
        
        barChart.setValue(forRedBar: record.numberOfRight,
                          BlackBar: record.numberOfWrong,
                          GrayBar: record.numberOfPass)
        barChart.bottomLabel.text = "\(record.TestNum)회"
    }
    
}

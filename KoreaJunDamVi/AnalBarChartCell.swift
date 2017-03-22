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
        
        
        switch record.Score {
        case 70...100:
            barChart.topLabel.text = "1급"
            
        case 60...69:
            barChart.topLabel.text = "2급"
            
        default:
            barChart.topLabel.text = "불합격"
            
        }

        
        barChart.setValue(forRedBar: record.numberOfRight,
                          BlackBar: record.numberOfWrong,
                          GrayBar: record.numberOfPass)
        barChart.bottomLabel.text = "\(record.TestNum)회"
    }
    
}

//
//  ProbSubCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbSubCollectionViewController: ProbCollectionViewController {

    var option: SortedOption = .note
    var pushHandler:((Int) -> Void)?
    
    @IBOutlet var label_Ranking1: UILabel!
    @IBOutlet var label_Ranking2: UILabel!
    @IBOutlet var label_Ranking3: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var analButton: JDVButton!
    
    @IBAction func analButtonPressed(_ sender: Any) {
        pushHandler?(pageIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "\(option.description) 출제 비중 TOP 3"
        self.analButton.setTitle("\(option.description) 분석자료 >>", for: .normal)
        
        let rank = JDVStatisticManager.shared.getTop3Info(type: self.option)
        if rank.count > 2 {
            label_Ranking1.text = " 1위 " + rank[0] + " "
            label_Ranking2.text = " 2위 " + rank[1] + " "
            label_Ranking3.text = " 3위 " + rank[2] + " "
        }
    }
}

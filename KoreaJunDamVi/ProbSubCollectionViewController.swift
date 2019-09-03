//
//  ProbSubCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbSubCollectionViewController: ProbCollectionViewController {

    var rankingStr:[String]!
    var subtitle: String!
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
        //configure data
        
        self.titleLabel.text = "\(subtitle!) 출제 비중 TOP 3"
        self.analButton.setTitle("\(subtitle!) 분석자료 >>", for: .normal)
        label_Ranking1.text = " 1위 " + rankingStr[0] + " "
        label_Ranking2.text = " 2위 " + rankingStr[1] + " "
        label_Ranking3.text = " 3위 " + rankingStr[2] + " "
        
    }
}

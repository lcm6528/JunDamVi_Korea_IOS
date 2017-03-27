//
//  ProbSubCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbSubCollectionViewController: ProbCollectionViewController {

    
    var subtitle:String!
    var pushHandler:((Int)->Void)?
    
    @IBOutlet var label_Ranking1: UILabel!
    @IBOutlet var label_Ranking2: UILabel!
    @IBOutlet var label_Ranking3: UILabel!
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var analButton: UIButton!
    
    @IBAction func analButtonPressed(_ sender: Any) {
        pushHandler?(pageIndex)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure data
        
        self.titleLabel.text = "\(subtitle!) 출제 비중 TOP 3"
        self.analButton.setTitle("\(subtitle!) 분석자료 >>", for: .normal)
        
    }
}

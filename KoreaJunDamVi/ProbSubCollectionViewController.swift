//
//  ProbSubCollectionViewController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbSubCollectionViewController: ProbCollectionViewController {

    
    var data:String!
    var pushHandler:((Int)->Void)?
    
    @IBOutlet var analButton: UIButton!
    
    @IBAction func analButtonPressed(_ sender: Any) {
        pushHandler?(pageIndex)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure data
    }
}

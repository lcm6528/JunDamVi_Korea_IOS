//
//  ProbQuickCell.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 2. 28..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class ProbQuickCell: UITableViewCell ,JDVRadioButtonManagerDelegate{

    
    @IBOutlet var btn1: JDVButton!
    @IBOutlet var btn2: JDVButton!
    @IBOutlet var btn3: JDVButton!
    @IBOutlet var btn4: JDVButton!
    @IBOutlet var btn5: JDVButton!
    @IBOutlet var titleLabel: UILabel!
    var probNum:Int!
    
    
    var manager:JDVRadioButtonManager?
    
    var SelectionHandelr:((Int,Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        manager = JDVRadioButtonManager(WithButtons: btn1,btn2,btn3,btn4,btn5)
        manager?.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func JDVRadioButtonManagerDelegate(_ manager: JDVRadioButtonManager, didSelectedButtonAtIndex index: Int) {
        
        
        self.SelectionHandelr?(probNum,index+1)
        
    }

}

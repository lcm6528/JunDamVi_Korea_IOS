//
//  JDVNoteMenuCell.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 26..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class JDVNoteMenuCell: UITableViewCell {

    @IBOutlet var label_probnum: UILabel!
    @IBOutlet var label_score: UILabel!
    @IBOutlet var label_time: UILabel!
    @IBOutlet var label_type: UILabel!
    @IBOutlet var label_tags: UILabel!
    
    func configure(by prob:Prob){
        
        label_probnum.text = "\(prob.ProbNum)"
        label_score.text = "\(prob.Score)"
        label_time.text = "\(prob.time?.rawValue ?? "-" )"
        label_type.text = "\(prob.type?.rawValue ?? "-")"
        label_tags.text = "\(prob.tags?[0] ?? "-")"
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        label_probnum.text = "-"
        label_score.text = "-"
        label_time.text = "-"
        label_type.text = "-"
        label_tags.text = "-"
        
    }

}

//
//  ProbResultBotView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class ProbResultBotView: UIView {
    
    var view: UIView!
    let NibName: String = "ProbResultBotView"
    var delegate: ProbResultSubViewDelegate?
    var dismissHandler: (() -> Void)?
    var addNoteHandler: (() -> Void)?
    
    @IBOutlet var noteButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var noteCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        
        noteButton.layer.cornerRadius = 4
        noteButton.layer.borderWidth = 0.5
        noteButton.layer.borderColor = UIColor.gray.cgColor
        
        tableView.register(UINib(nibName: "testheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "testheader")
        tableView.register(UINib(nibName: "ProbResultBotCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0
            ] as! UIView
        
        return view
    }
    
    func configure(result: TestResult) {
        noteCountLabel.text = "\(result.numberOfWrong) 개"
    }
    
    @IBAction func changeView(_ sender: AnyObject) {
        self.delegate?.changeView()
    }
    
    @IBAction func goNote(_ sender: Any) {
        dismissHandler?()
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        sender.isEnabled = false
        sender.backgroundColor = .gray
        addNoteHandler?()
    }
}

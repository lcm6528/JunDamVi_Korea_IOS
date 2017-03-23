//
//  ProbResultBotView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 12. 12..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit



class ProbResultBotView: UIView ,UITableViewDelegate{
    
    var view:UIView!
    
    
    let NibName:String = "ProbResultBotView"
    
    var delegate:ProbResultSubViewDelegate?
    
    var dismissHandler:(()->Void)?
    
    @IBOutlet var noteButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
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
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        noteButton.layer.cornerRadius = 4
        noteButton.layer.borderWidth = 0.5
        noteButton.layer.borderColor = UIColor.gray.cgColor
        
        
        tableView.register(UINib(nibName: "testheader", bundle: nil), forHeaderFooterViewReuseIdentifier: "testheader")
        tableView.register(UINib(nibName: "ProbResultBotCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "NanumBarunGothicUltraLight", size: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("요약 결과 보기", for: .normal)
        button.addTarget(self, action: #selector(changeView(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        v.backgroundColor = UIColor.clear
        v.addSubview(button)
        tableView.tableHeaderView = v
        
        
        
        addSubview(view)
        
        
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0
            ] as! UIView
        
        
        return view
    }
    func changeView(_ sender: AnyObject) {
        self.delegate?.changeView()
    }
    
    
    @IBAction func goNote(_ sender: Any) {
        dismissHandler?()
    }
    
    
    
    
}

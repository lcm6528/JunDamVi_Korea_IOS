//
//  BlockView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 1..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit

class BlockView: UIView {
    
    
    var view:UIView!
    
    
    let NibName: String = "BlockView"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var sampleButton: UIButton!
    
    var actionHandler: ((Int) -> Void)?
    
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
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        titleLabel.layer.cornerRadius = 15
        purchaseButton.layer.cornerRadius = 3
        sampleButton.layer.cornerRadius = 3
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    
    @IBAction func buyButtonAction(_ sender: AnyObject) {
        
        self.actionHandler?(sender.tag)
    }
    
    @IBAction func preViewButtonAction(_ sender: AnyObject) {
        
        self.actionHandler?(sender.tag)
    }
    
}

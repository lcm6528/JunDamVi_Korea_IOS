//
//  JDVChoiceLabelManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 4. 26..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
@objc protocol JDVChoiceViewManagerDelegate{
    
    @objc optional func JDVChoiceViewManagerDelegate(_ manager:JDVChoiceViewManager ,didSelectedLabelAtIndex index:Int)
    
}
class JDVChoiceViewManager: NSObject {
    
    enum StateOfChoice{
        case selected
        case auth
        case normal
    }
    
    
    
    var isActive:Bool?{
        get{
            return self.isActive
        }
        set(isActive){
            
            if isActive == true{
                for view in arrayOfViews{
                    view.isUserInteractionEnabled = true
                }
            }else{
                for view in arrayOfViews{
                    view.isUserInteractionEnabled = false
                }
            }
            
        }
    }
    
    var arrayOfViews:[UIView]!
    var indexOfPage:Int!
    
    var delegate:JDVChoiceViewManagerDelegate?
    
    init(WithViews views:UIView ...){
        super.init()
        arrayOfViews = views
        
        for label in arrayOfViews!{
            let gesture = UITapGestureRecognizer(target: self, action:#selector(JDVChoiceViewManager.touchOnLabel(_:)))
            label.addGestureRecognizer(gesture)
            
        }
        
    }
    
    func touchOnLabel(_ sender:UITapGestureRecognizer){
        
        let index:Int = arrayOfViews.index(of: sender.view!)!
        selectLabelAtIndex(index)
        
        
        
        self.delegate?.JDVChoiceViewManagerDelegate?(self, didSelectedLabelAtIndex: index)
    }
    
    
    func setColorForStateAtIndex(_ index:Int, state:StateOfChoice){
        
        let view = arrayOfViews[index]
        
        switch state{
        case .selected:
            view.backgroundColor = UIColor.selectedBackgroundRed
            view.layer.borderColor = UIColor.selectedBorderRed.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 3
            
        case .auth:
            view.backgroundColor = UIColor.authBackgorundSkyBlue
            view.layer.borderColor = UIColor.authborderSkyBlue.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 3
            
            
            
        case .normal:
            view.backgroundColor = UIColor.white
            view.layer.borderColor = UIColor.clear.cgColor
            view.layer.borderWidth = 0
            view.layer.cornerRadius = 0
            
        }
        
    }
    
    func selectLabelAtIndex(_ index:Int){
        
        
        
        for (idx,_)in arrayOfViews.enumerated(){
            
            
            setColorForStateAtIndex(idx, state: .normal)
            if idx == index{
                setColorForStateAtIndex(idx, state: .selected)
            }
            
            
        }
    }
    
    
    
}

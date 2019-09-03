//
//  JDVChoiceLabelManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 4. 26..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//
//
//import UIKit
//@objc protocol JDVChoiceViewManagerDelegate{
//
//    @objc optional func JDVChoiceViewManagerDelegate(_ manager:JDVChoiceViewManager ,didSelectedLabelAtIndex index: Int)
//
//}
//class JDVChoiceViewManager: NSObject {
//
//
//
//    var isActive:Bool?{
//        get{
//            return self.isActive
//        }
//
//        set(isActive) {
//
//            if isActive == true{
//                for view in arrayOfViews{
//                    view?.isUserInteractionEnabled = true
//                }
//            } else {
//                for view in arrayOfViews{
//                    view?.isUserInteractionEnabled = false
//                }
//            }
//
//        }
//    }
//
//    var arrayOfViews: [UIView?] = [nil, nil, nil, nil, nil]
//    var indexOfPage: Int!
//
//    var delegate:JDVChoiceViewManagerDelegate?
//
//    init(WithViews views:UIView ...) {
//        super.init()
//        arrayOfViews = views
//
//        for label in arrayOfViews{
//            let gesture = UITapGestureRecognizer(target: self, action:#selector(JDVChoiceViewManager.touchOnLabel(_:)))
//            label?.addGestureRecognizer(gesture)
//        }
//    }
//
//    func setView(view: UIView, index: Int) {
//        arrayOfViews[index] = view
//        let gesture = UITapGestureRecognizer(target: self, action:#selector(JDVChoiceViewManager.touchOnLabel(_:)))
//        view.addGestureRecognizer(gesture)
//    }
//
//    @objc func touchOnLabel(_ sender:UITapGestureRecognizer) {
//
//        let index: Int = arrayOfViews.index(of: sender.view!)!
//        selectLabelAtIndex(index)
//
//        self.delegate?.JDVChoiceViewManagerDelegate?(self, didSelectedLabelAtIndex: index)
//    }
//
//    func selectLabelAtIndex(_ index: Int) {
//        for (idx,_)in arrayOfViews.enumerated() {
//            setColorForStateAtIndex(idx, state: .normal)
//            if idx == index{
//                setColorForStateAtIndex(idx, state: .selected)
//            }
//        }
//    }
//}

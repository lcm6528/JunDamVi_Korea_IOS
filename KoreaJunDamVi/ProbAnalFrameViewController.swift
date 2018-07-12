//
//  JDVProbAnalFrameViewController.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 1. 10..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import UIKit
import PageMenu

class JDVProbAnalFrameViewController: JDVViewController {
    
    var pageMenu: CAPSPageMenu?
    var data: [(String,Float)] = []
    var contentData: [String] = []
    var dataObject: [String: String]!
    var contentObject: [String: String]!
    var option: JDVProbManager.SortedOption!
    @IBOutlet var graph: JDVGraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = dataObject.map{
            return ($0.key, $0.value.toFloat()!)
        }
        data.shuffle()
        for item in data {
            contentData.append(contentObject[item.0] ?? "분석자료가 없습니다.")
        }
        
        self.setTitleWithStyle(option.description + " 분석자료")
        
        graph.setData(model: JDVGraphModel(arrayLiteral: data))
        graph.setHighlight(toStanding: 3)
        
        var controllerArray: [UIViewController] = []
        
        for (index,element) in data.enumerated() {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "JDVAnalContentViewController") as! JDVAnalContentViewController
            controller.title = element.0
            controller.content = contentData[index]
            controllerArray.append(controller)
        }
        
        let parameters: [CAPSPageMenuOption] = [
            .viewBackgroundColor(UIColor.clear),
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .addBottomMenuHairline(true),
            .selectionIndicatorColor(UIColor.black),
            .selectedMenuItemLabelColor(UIColor.black),
            .selectionIndicatorHeight(2.0),
            .menuHeight(40.0),
            .menuItemMargin(10.0)
        ]
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graph.animate(withDuration: 0.8)
    }
}

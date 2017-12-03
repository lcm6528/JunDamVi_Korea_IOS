//
//  TabbarController.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 12. 4..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit
import TransitionableTab

class HomeTabbarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension HomeTabbarController: TransitionableTab{
    func transitionDuration() -> CFTimeInterval {
        return 0.25
    }
    
    
    func fromTransitionAnimation(layer: CALayer, direction: Direction) -> CAAnimation {
//        return DefineAnimation.move(.from, direction: direction)
        return DefineAnimation.fade(.from)
        
    }
    
    func toTransitionAnimation(layer: CALayer, direction: Direction) -> CAAnimation {
        return DefineAnimation.fade(.to)
//        return DefineAnimation.move(.to, direction: direction)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}

//
//  Radian.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 10. 25..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit
let π = CGFloat(M_PI)


func degreesToRadians (value:CGFloat) -> CGFloat {
  return value * π / 180.0
}

func radiansToDegrees (value:CGFloat) -> CGFloat {
  return value * 180.0 / π
}

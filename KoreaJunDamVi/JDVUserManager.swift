//
//  JDVUserManager.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 04/09/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import Foundation
import UIKit

class JDVUserManager : NSObject {
    
    static var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    
}


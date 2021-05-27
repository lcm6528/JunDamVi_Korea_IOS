//
//  JDVFonts.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 24..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class var NaviBarTitleFont: UIFont {
        return UIFont(name: "NanumBarunGothicLight", size: 18)!
    }
    class var ProbNaviBarTitleFont: UIFont {
        return UIFont(name: "NanumBarunGothicLight", size: 16)!
    }
    class var EmptySetTitle: UIFont {
        return UIFont(name: "NanumBarunGothicLight", size: 13)!
    }
    class var titleFont: UIFont {
        if UIDevice.current.isPad {
            return UIFont(name: "NanumMyeongjo", size: 18)!
        } else {
            return UIFont(name: "NanumMyeongjo", size: 15)!
        }
    }
    class var articleFont: UIFont {
        if UIDevice.current.isPad {
            return UIFont(name: "NanumMyeongjo", size: 18)!
        } else {
            return UIFont(name: "NanumMyeongjo", size: 15)!
        }
    }
    class var choiceFont: UIFont {
        if UIDevice.current.isPad {
            return UIFont(name: "NanumMyeongjo", size: 18)!
        } else {
            return UIFont(name: "NanumMyeongjo", size: 15)!
        }
    }
    class var solutionFont: UIFont {
        if UIDevice.current.isPad {
            return UIFont(name: "NanumMyeongjo", size: 18)!
        } else {
            return UIFont(name: "NanumMyeongjo", size: 15)!
        }
    }
    class var scoreFont: UIFont {
        if UIDevice.current.isPad {
            return UIFont(name: "NanumMyeongjoExtraBold", size: 18)!
        } else {
            return UIFont(name: "NanumMyeongjoExtraBold", size: 15)!
        }
    }
    
    static func lightFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AppleSDGothicNeo-Light", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize:size)
    }
    
    static func regularFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AppleSDGothicNeo-Regular", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize:size)
    }
    
    static func mediumFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AppleSDGothicNeo-Medium", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize:size)
    }
}

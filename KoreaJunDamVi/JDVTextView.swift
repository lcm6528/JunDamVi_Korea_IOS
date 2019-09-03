//
//  JDVTextView.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2016. 11. 27..
//  Copyright © 2016년 JunDamVi. All rights reserved.
//

import UIKit

class JDVTextViewPadding : UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
}

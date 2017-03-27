//
//  JDVBarButtonItem.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 15..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

class JDVBarButtonItem : UIBarButtonItem {
  
  fileprivate var actionHandler: ((Void) -> Void)?
  
  convenience init(title: String?, style: UIBarButtonItemStyle, actionHandler: ((Void) -> Void)?) {
    self.init(title: title, style: style, target: nil, action: nil)
    self.target = self
    self.action = #selector(JDVBarButtonItem.barButtonItemPressed(_:))
    self.actionHandler = actionHandler
  }
  
  func barButtonItemPressed(_ sender: UIBarButtonItem) {
    if let actionHandler = self.actionHandler {
      actionHandler()
    }
  }
  
}


class JDVNoteBarButtonItem: UIBarButtonItem{
    
    var isSelected:Bool = false{
        didSet{
            self.image = isSelected ? UIImage(named: "star_selected") : UIImage(named: "star")
        }
    }
    
}

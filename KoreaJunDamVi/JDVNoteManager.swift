//
//  JDVNoteManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 8..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import RealmSwift
import Toaster
class JDVNoteManager: NSObject {
  
    static func saveNote(by note:Note){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(note)
            Toast(text: "오답노트 저장완료").show()
        }
        
    }
  
    
    //TODO : CURD
}

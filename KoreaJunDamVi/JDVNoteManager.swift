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
  
    static func saveNote(by note:Note) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(note)
            ToastCenter.default.cancelAll()
            Toast(text: "오답노트 저장완료").show()
        }
        
    }
  
    static func deleteNote(by note:Note) {
        
        let realm = try! Realm()
        let object = realm.object(ofType: Note.self, forPrimaryKey: note.ProbID)
        
        try! realm.write {
            if object != nil {
                realm.delete(object!)
            }
            ToastCenter.default.cancelAll()
            Toast(text: "오답노트 삭제완료").show()
        }
        
    }
    
    static func isAdded(by probid: Int)->Bool {
        
        let realm = try! Realm()
        if let _ = realm.object(ofType: Note.self, forPrimaryKey: probid) {
            return true
        } else {
            return false
        }
        
    }
    
    //TODO : CURD
}

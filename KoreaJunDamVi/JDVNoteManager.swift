//
//  JDVNoteManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 8..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import CoreData
class JDVNoteManager: NSObject {
  
  
  static func saveNoteWithUserInfo(_ userInfo:NSDictionary)->NSManagedObjectID?{
    
    let context = DataController().managedObjectContext
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
    
    entity.setValue(userInfo["year"], forKey: "year")
    entity.setValue(userInfo["num"], forKey: "num")
    entity.setValue(userInfo["trial"], forKey: "trial")
    entity.setValue(userInfo["auth"], forKey: "auth")
    entity.setValue(userInfo["date"], forKey: "date")
    entity.setValue(userInfo["type"], forKey: "type")
    
    
    
    
    do{
      try context.save()
      return entity.objectID
    }catch{
      return nil
    }
    
  }
  
  
  static func deleteNoteWithObjectID(_ id:NSManagedObjectID)->Bool{
        let context = DataController().managedObjectContext
    do{
      let obj = context.object(with: id)
      context.delete(obj)
      try context.save()
      return true
    }catch{
      return false
    }
    
  }
  
}

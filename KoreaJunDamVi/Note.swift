//
//  Note.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 6..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import RealmSwift


class Note: Object {
    @objc dynamic var ProbID: Int = 0
    @objc dynamic var Selection: Int = 0
    
    override static func primaryKey() -> String? {
        return "ProbID"
    }
}


struct NoteData {
    var prob: Prob
    var sol: Solution
    var note: Note
    
    var probID: Int {
        return prob.ProbID
    }
    
    var selection: Int {
        return note.Selection
    }
    
    var desc: String {
        return "\(prob.TestNum)회 \(prob.ProbNum)번"
    }
}

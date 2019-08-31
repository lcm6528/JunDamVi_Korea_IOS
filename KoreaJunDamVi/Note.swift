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


struct ProbData {
    var prob: Prob
    var sol: Solution
    var note: Note?
    
    var probID: Int {
        return prob.ProbID
    }
    
    var selection: Int {
        return note?.Selection ?? 0
    }
    
    var desc: String {
        return "\(prob.TestNum)회 \(prob.ProbNum)번"
    }
    
    var answer: Int {
        return prob.Answer - 1
    }
    
    init(withDict dict:NSDictionary) {
        self.prob = Prob(withDict: dict)
        self.sol = Solution(withDict: dict)
    }
}

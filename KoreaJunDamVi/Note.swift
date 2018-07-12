//
//  Note.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 6..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import RealmSwift


class Note:Object{
    @objc dynamic var ProbID: Int = 0
    @objc dynamic var Selection: Int = 0
    
    override static func primaryKey() -> String? {
        return "ProbID"
    }
}

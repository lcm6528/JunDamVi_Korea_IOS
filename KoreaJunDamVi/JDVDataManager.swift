//
//  JDVDataManager.swift
//  KoreaJunDamVi
//
//  Created by ayden.lee on 2021/02/09.
//  Copyright © 2021 JunDamVi. All rights reserved.
//

import Foundation

class JDVDataManager: NSObject {
    static func saveCurrentSelection(key: String, selections: [Int]) {
        setUserDefault(value: selections, forKey: key)
    }
    
    static func getSelection(key: String) -> [Int]? {
        return getUserDefault(key) as? [Int]
    }
    
    static func deleteCachedData(key: String) {
        deleteUserDefalut(key)
    }
}

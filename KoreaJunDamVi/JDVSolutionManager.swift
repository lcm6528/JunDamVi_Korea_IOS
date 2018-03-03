//
//  JDVSolutionManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 6. 29..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import FMDB



class JDVSolutionManager: NSObject {
    
    static func fetchSols(withTestnum num: Int)->[Solution]{
        
        var Sols:[Solution] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb?.open())! {
            
            let sql1 = "SELECT * FROM Solvs WHERE testnum = \(num)"
            let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
            while result?.next() == true {
                let dict:NSDictionary = result!.resultDictionary() as NSDictionary
                let sol = Solution(withDict: dict)
                
                Sols.append(sol)
            }
        }
        fmdb?.close()
        return Sols
    }
    
    static func fetchSol(withProbID id: Int)->Solution?{
        
        var sol:Solution?
        
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb?.open())! {
            
            let sql1 = "SELECT * FROM Solvs WHERE probid = \(id)"
            let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
            while result?.next() == true {
                let dict:NSDictionary = result!.resultDictionary() as NSDictionary
                let item = Solution(withDict: dict)
                
                sol = item
            }
        }
        fmdb?.close()
        
        return sol
        
    }
    
    
    
        
    
}

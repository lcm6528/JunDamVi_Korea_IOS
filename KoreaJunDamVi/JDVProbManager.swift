//
//  JDVProbManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 6. 28..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit
import FMDB

class JDVProbManager: NSObject {
    
    
    static func fetchProbs(withTestnum num:Int)->[Prob]{
        
        var Probs:[Prob] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb?.open())! {
            
            let sql1 = "SELECT * FROM Probs WHERE testnum = \(num)"
            let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
            while result?.next() == true {
                let dict:NSDictionary = result!.resultDictionary() as NSDictionary
                let prob = Prob(withDict: dict)
                
                Probs.append(prob)
            }
        }
        fmdb?.close()
        return Probs
    }
    
    static func fetchProb(withProbID id:Int)->Prob?{
        
        var prob:Prob?
        
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb?.open())! {
            
            let sql1 = "SELECT * FROM Probs WHERE probid = \(id)"
            let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
            while result?.next() == true {
                let dict:NSDictionary = result!.resultDictionary() as NSDictionary
                let item = Prob(withDict: dict)
                
                prob = item
            }
        }
        fmdb?.close()
        
        return prob
        
        
    }
    static func fetchProbs(withProbID ids:[Int])->[Prob]{
        
        var probs:[Prob] = []
        
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb?.open())! {
            
            for id in ids{
                let sql1 = "SELECT * FROM Probs WHERE probid = \(id)"
                let result = fmdb?.executeQuery(sql1, withArgumentsIn: nil)
                while result?.next() == true {
                    let dict:NSDictionary = result!.resultDictionary() as NSDictionary
                    let item = Prob(withDict: dict)
                    probs.append(item)
                    
                }
            }
            
        }
        fmdb?.close()
        
        return probs
        
        
    }
    
    
    
    
    
    static func saveCachedData(with key:String, tries:[Int]){
        
        var data = ""
        for item in tries{
            data += "\(item)/"
        }
        data = data.substring(to: data.index(data.startIndex, offsetBy: data.length-1))
        setUserDefault(value: data, forKey: key)
    }
    
    
    static func getCachedData(with key:String)->[Int]?{
        
        let data = getUserDefault(key) as? String
        let selections = data?.components(separatedBy: "/").map{ item in
            return item.toInt()!
        }
        return selections
        
    }
    
    static func deleteCachedData(with key:String){
        
        deleteUserDefalut(key)
        
    }
    
}

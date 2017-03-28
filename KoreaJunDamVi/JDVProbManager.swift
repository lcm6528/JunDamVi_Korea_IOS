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
    
    struct ProbOption{
        
        var sortedOption:SortedOption = .test
        var cacheKey:String = ""
        
    }
    
    enum SortedOption:String{
        case test = "testnum"
        case time = "time"
        case theme = "theme"
        case type = "type"
        
        var description: String {
            switch self {
            case .test:
                return "회차별"
            case .time:
                return "시대별"
            case .theme:
                return "테마별"
            case.type:
                return "유형별"
            }
        }
    }
    
    static func fetchProbs(withSortedOption option:SortedOption,by value:String)->[Prob]{
        
        var Probs:[Prob] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        let val = (option != .test) ?  ("\"" + value + "\"") : (value)
        
        if (fmdb?.open())! {
            
            let sql1 = "SELECT * FROM Probs WHERE \(option.rawValue) = \(val)"
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
        
        setUserDefault(value: tries, forKey: key)
    }
    
    
    static func getCachedData(with key:String)->[Int]?{
        
        return getUserDefault(key) as? [Int]
        
    }
    
    static func deleteCachedData(with key:String){
        deleteUserDefalut(key)
    }
    
}

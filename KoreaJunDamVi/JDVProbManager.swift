//
//  JDVProbManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 6. 28..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//
// TOTO : fetch 함수들에 completion 블럭을 넣도록 바꾸자.

import UIKit
import FMDB

enum SortedOption: String {
    case test = "testnum"
    case time = "time"
    case theme = "theme"
    case type = "type"
    case note = "note"
    
    var description: String {
        switch self {
        case .test:
            return "회차별"
        case .time:
            return "시대별"
        case .theme:
            return "테마별"
        case .type:
            return "유형별"
        case .note:
            return "오답 노트"
        }
    }
}

class JDVProbManager: NSObject {
    
    struct ProbOption {
        var sortedOption: SortedOption = .test
        var cacheKey: String = ""
    }
    
    
    
    static func fetchProbs(withSortedOption option: SortedOption, by value: String, completion:@escaping ([ProbData]) -> ()) {
        
        var Probs: [ProbData] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        let val = (option != .test) ?  ("\"" + value + "\"") : (value)
        if (fmdb.open()) {
            
            let sql1 = "SELECT * FROM Probs WHERE \(option.rawValue) = \(val)"
            let result = fmdb.executeQuery(sql1, withArgumentsIn: [])
            var arr = [NSDictionary]()
            while result?.next() == true {
                if let result = result?.resultDictionary as NSDictionary? {
                    arr.append(result)
                }
            }
           
            arr.forEach({ (dict) in
                Probs.append(ProbData(withDict: dict))
            })
            
            completion(Probs)
        }
        fmdb.close()
    }
    
    static func fetchProbs(withTestnum num: Int) -> [ProbData] {
        var Probs: [ProbData] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb.open()) {
            
            let sql1 = "SELECT * FROM Probs WHERE testnum = \(num)"
            let result = fmdb.executeQuery(sql1, withArgumentsIn: [])
            while result?.next() == true {
                if let result = result?.resultDictionary as NSDictionary? {
                    let prob = ProbData(withDict: result)
                    Probs.append(prob)
                }
            }
        }
        fmdb.close()
        return Probs
    }
    
    static func fetchProb(withProbID id: Int) -> ProbData? {
        var prob: ProbData?
        
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb.open()) {
            
            let sql1 = "SELECT * FROM Probs WHERE probid = \(id)"
            let result = fmdb.executeQuery(sql1, withArgumentsIn: [])
            while result?.next() == true {
                
                if let result = result?.resultDictionary as NSDictionary? {
                    let item = ProbData(withDict: result)
                    prob = item
                }
            }
        }
        fmdb.close()
        return prob
    }
    
    static func fetchProbs(withProbID ids:[Int]) -> [ProbData] {
        
        var probs: [ProbData] = []
        
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb.open()) {
            for id in ids{
                let sql1 = "SELECT * FROM Probs WHERE probid = \(id)"
                let result = fmdb.executeQuery(sql1, withArgumentsIn: [])
                while result?.next() == true {
                    if let result = result?.resultDictionary as NSDictionary? {
                        let item = ProbData(withDict: result)
                        probs.append(item)
                    }
                }
            }
        }
        fmdb.close()
        return probs
    }
    
    static func saveCachedData(with key: String, tries: [Int] ) {
        setUserDefault(value: tries, forKey: key)
    }
    
    
    static func getCachedData(with key: String) -> [Int]? {
        return getUserDefault(key) as? [Int]
    }
    
    static func deleteCachedData(with key: String) {
        deleteUserDefalut(key)
    }
    
    //QuickProbs
    static func fetchQuickProbs(withTestnum num: Int) -> [QuickProb] {
        var Probs: [QuickProb] = []
        let dbPath = Bundle.main.url(forResource: "Database", withExtension: "db")
        let fmdb = FMDatabase(path: dbPath?.path)
        
        if (fmdb.open()) {
            
            let sql1 = "SELECT probId, testnum, probnum, answer, answer, score  FROM Probs WHERE testnum = \(num)"
            let result = fmdb.executeQuery(sql1, withArgumentsIn: [])
            while result?.next() == true {
                if let result = result?.resultDictionary as NSDictionary? {
                    let prob = QuickProb(withDict: result)
                    
                    Probs.append(prob)
                }
//                let dict:NSDictionary = result!.resultDictionary() as NSDictionary
//                let prob = QuickProb(withDict: dict)
//
//                Probs.append(prob)
            }
        }
        fmdb.close()
        return Probs
    }
}

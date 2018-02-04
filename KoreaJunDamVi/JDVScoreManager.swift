//
//  JDVScoreManager.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 5. 16..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import UIKit

class JDVScoreManager: NSObject {
    
    struct SimpleResult {
        var Score:Int
        var TestNum:Int
        init(withKey key:String) {
            Score = getUserDefaultIntValue("\(key)score")
            TestNum = getUserDefaultIntValue("\(key)testnum")
        }
    }
    
    struct AnalModel {
        var high:SimpleResult
        var row:SimpleResult
        var recent:SimpleResult
        init() {
            high = SimpleResult(withKey: "high")
            row = SimpleResult(withKey: "row")
            recent = SimpleResult(withKey: "recent")
        }
    }
    
    static func configureAnalData(by result:TestResult) {
        
        let setScoreAndTestNum:(String)->() = { key in
            setUserDefaultWithInt(result.TotalScore, forKey: "\(key)score")
            setUserDefaultWithInt(Int(result.TestKey) ?? 0, forKey: "\(key)testnum")
            
        }
        
        //Set recent score
        setScoreAndTestNum("recent")
        
        //Set high score
        
        let high = getUserDefaultIntValue("highscore")
        if high <= result.TotalScore{
            setScoreAndTestNum("high")
        }
        
        //Set row score
        let row = getUserDefaultIntValue("rowscore")
        if row == 0 || row >= result.TotalScore{
            setScoreAndTestNum("row")
        }
        
    }
    
    
    static func getTime(_ year:Int, type:String)-> Int{
        let keyString = "\(year)\(type)"
        var time  = getUserDefaultIntValue(keyString)
        
        if time == 0{
            
            time = 1
        }
        
        return time
        
    }
    
    
}

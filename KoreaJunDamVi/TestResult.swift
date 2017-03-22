//
//  TestResult.swift
//  KoreaJunDamVi
//
//  Created by 이창민 on 2017. 2. 27..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import RealmSwift


class TestResultRecord:Object{
    dynamic var TestNum:Int = 0
    dynamic var numberOfRight:Int = 0
    dynamic var numberOfPass:Int = 0
    dynamic var numberOfWrong:Int = 0
    dynamic var Score:Int = 0
    
    convenience init(by result:TestResult){
        self.init()
        
        self.TestNum = result.TestNum
        self.numberOfRight = result.numberOfRight
        self.numberOfPass = result.numberOfPass
        self.numberOfWrong = result.numberOfWrong
        self.Score = result.TotalScore

    }
    
}


enum state:String {
    
    case Right = "O"
    case Wrong = "X"
    case Pass = "Pass"
    
}
struct Try {
    
    
    
    var Score:Int
    var ProbID:Int
    var Selection:Int
    var Answer:Int
    var TestNum:Int
    var ProbNum:Int
    var State:state = .Pass
    
    init(withProb prob:Prob,selection select:Int){
        self.ProbNum = prob.ProbNum
        self.TestNum = prob.TestNum
        self.ProbID = prob.ProbID
        self.Score = prob.Score
        self.Answer = prob.Answer
        self.Selection = select
        
        if Answer == Selection{
            self.State = .Right
        }else{
            self.State = (Selection == 0) ? (.Pass) : (.Wrong)
        }
    }
    
}

struct TestResult{
    
    var TryNum:Int?
    var TotalScore:Int = 0
    var TestNum:Int
    
    var Tries:[Try] = []
    
    var numberOfRight:Int = 0
    var numberOfWrong:Int = 0
    var numberOfPass:Int = 0
    
    init(withTries tries:[Try]){
        self.TestNum = tries[0].TestNum
        self.Tries = tries
        calculateScore()
        
    }
    
    
    mutating func calculateScore(){
        
        
        
        for Try in Tries{
            switch Try.State {
            case .Right:
                TotalScore += Try.Score
                numberOfRight += 1
            case .Wrong:
                numberOfWrong += 1
            case .Pass:
                numberOfPass += 1
                
            }
        }
    }
}

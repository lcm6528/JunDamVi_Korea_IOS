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
    
    @objc dynamic var TestType: String = ""
    @objc dynamic var TestKey: String = ""
    @objc dynamic var numberOfRight: Int = 0
    @objc dynamic var numberOfPass: Int = 0
    @objc dynamic var numberOfWrong: Int = 0
    @objc dynamic var Score: Int = 0
    
    convenience init(by result:TestResult) {
        self.init()
        
        self.TestType = result.TestType
        self.TestKey = result.TestKey
        self.numberOfRight = result.numberOfRight
        self.numberOfPass = result.numberOfPass
        self.numberOfWrong = result.numberOfWrong
        self.Score = result.TotalScore

    }
    
}


enum state: String {
    case Right = "O"
    case Wrong = "X"
    case Pass = "Pass"
}

struct Try {
    
    var Score: Int
    var ProbID: Int
    var Selection: Int
    var Answer: Int
    var TestNum: Int
    var ProbNum: Int
    var State:state = .Pass
    
    init(withProb prob:Prob,selection select: Int) {
        self.ProbNum = prob.ProbNum
        self.TestNum = prob.TestNum
        self.ProbID = prob.ProbID
        self.Score = prob.Score
        self.Answer = prob.Answer
        self.Selection = select
        
        if Answer == Selection {
            self.State = .Right
        } else {
            self.State = (Selection == 0) ? (.Pass) : (.Wrong)
        }
    }
    init(withQuickProb prob:QuickProb,selection select: Int) {
        self.ProbNum = prob.ProbNum
        self.TestNum = prob.TestNum
        self.ProbID = prob.ProbID
        self.Score = prob.Score
        self.Answer = prob.Answer
        self.Selection = select
        
        if Answer == Selection {
            self.State = .Right
        } else {
            self.State = (Selection == 0) ? (.Pass) : (.Wrong)
        }
    }
    
    
}

enum ResultType: String {
    case grade1 = "1급"
    case grade2 = "2급"
    case grade3 = "3급"
    case fail = "불합격"
    
    func getComment() -> String {
        switch self {
        case .grade1:
            return "당신은 한국사 마스터!"
        case .grade2:
            return "1급에 도전하세요!"
        case .grade3:
            return "1급에 도전하세요!"
        case .fail:
            return "포기하지 마세요!"
        }
    }
}

struct TestResult {
    
    var TryNum: Int?
    var TotalScore: Int = 0
    var TestType: String
    var TestKey: String
    var testNum = 0
    
    var result: ResultType = .fail
    
    var Tries: [Try] = []
    
    var numberOfRight: Int = 0
    var numberOfWrong: Int = 0
    var numberOfPass: Int = 0
    
    init(testNum: Int = 0, TestType type: String,forKey key: String, withTries tries: [Try]) {
        self.TestType = type
        self.TestKey = key
        self.Tries = tries
        self.testNum = testNum
        calculateScore()
    }
    
    mutating func calculateScore() {
        for Try in Tries {
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
        
        if self.testNum < 47 {
            switch self.TotalScore {
            case 70...100:
                self.result = .grade1
            case 60...69:
                self.result = .grade2
            default:
                self.result = .fail
            }
        } else {
            switch self.TotalScore {
            case 80...100:
                self.result = .grade1
            case 70...79:
                self.result = .grade2
            case 60...69:
                self.result = .grade3
            default:
                self.result = .fail
            }
        }
    }
}

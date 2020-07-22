//
//  JDVLogManager.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 19/10/2019.
//  Copyright © 2019 JunDamVi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

fileprivate let kProblem_Code = "problem_code"
fileprivate let kAnswer_User = "answer_user"
fileprivate let kCode_User = "code_user"
fileprivate let kId_User = "id_user"
fileprivate let kUser_Action = "user_action"
fileprivate let kTime_Checked = "time_chekced"
fileprivate let kBASE_URL = "http://ec2-13-125-171-111.ap-northeast-2.compute.amazonaws.com:3000/problem_log/ios"
public enum SELECT_TYPE: String {
    case TEST_NUM = "test_num"
    case TEST_ERA = "test_era"
    case TEST_TYPE = "test_type"
    case TEST_THEME = "test_theme"
    case NOTE = "note"
}

private struct JDVLog {
    var probID: Int
    var selection: Int
    var action: SELECT_TYPE
    
    var json: JSON {
        var json = JSON()
        json[kProblem_Code].stringValue = "0\(probID)"
        json[kAnswer_User].intValue = selection
        json[kId_User].stringValue = ""
        json[kUser_Action].stringValue = action.rawValue
        json[kTime_Checked].intValue = Int(Date().timeIntervalSince1970)
        return json
    }
    
    init(probID: Int, selection: Int, action: SELECT_TYPE) {
        self.probID = probID
        self.selection = selection
        self.action = action
    }
}

public class JDVLogManager: NSObject {
    public static var shared: JDVLogManager = JDVLogManager()
    private var logs: [JDVLog] = [] {
        didSet {
            if logs.count > 5 {
                save()
            }
        }
    }
    
    public func addLog(probID: Int, selection: Int, action: SELECT_TYPE) {
        let log = JDVLog(probID: probID, selection: selection, action: action)
        logs.append(log)
    }
    
    public func save() {
        var dict = [String : Any]()
        let logsJSON = JSON(arrayLiteral: logs.map({$0.json}))
        if let data = logsJSON.dictionaryObject {
            dict["log"] = data
            request(data: dict)
        }
    }
    
    private func request(data: [String : Any]) {
        Alamofire.request(kBASE_URL, method: .post, parameters: data, encoding: JSONEncoding.default, headers: nil).response { (response) in
            if let error = response.error {
                print("Save Log ERROR \(error.localizedDescription)")
            } else {
                self.logs.removeAll()
            }
        }
    }
}


class ClientLogger {
    static func log(log: String) {
        print("[JDVLOG] \(log)")
    }
}

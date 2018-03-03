//
//  MNVersion.swift
//  Donggam
//
//  Created by 이창민 on 2017. 1. 5..
//  Copyright © 2017년 UCAN. All rights reserved.
//

import UIKit

class MNVersion: NSObject {
    
    static func getLatestVersion() -> String? {
        //sync 문제가 있음. 애플서버 동기화가 느리다.
        let info = Bundle.main.infoDictionary
        let appID = info?["CFBundleIdentifier"]  as? String ?? ""
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(appID)")!
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any] else {
            return nil
        }
        let num = json["resultCount"] as! Int
        if num == 1 {
            if let results = json["results"] as? [Any] {
                if let result = results[0] as? [String:Any] {
                    let version = result["version"] as! String
                    return version
                }
            }
        }
        return nil
    }
    
    static var currentVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

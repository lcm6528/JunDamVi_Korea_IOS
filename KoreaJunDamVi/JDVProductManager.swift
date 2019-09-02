//
//  JDVProductManager.swift
//  KoreaJunDamVi
//
//  Created by changmin lee on 2017. 3. 31..
//  Copyright © 2017년 JunDamVi. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import Toaster

let ProductID = "koreasolutions"

class JDVProductManager : NSObject {

    static func isPurchased() -> Bool {
        return getUserDefaultBoolValue(ProductID)
    }
    
    static func Purchase(completion:@escaping (_ success: Bool) -> Void) {
        SwiftyStoreKit.purchaseProduct(ProductID, atomically: true) { result in
            switch result {
            case .success:
                Toast(text: "구매 성공!").show()
                setUserDefaultWithBool(true, forKey: ProductID)
                completion(true)
            case .error:
                Toast(text: "결제 중 오류가 발생했습니다.").show()
                completion(false)
            }
        }
    }
}

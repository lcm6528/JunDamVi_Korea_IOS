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


class JDVProductManager : NSObject{
    
    
    static func isPurchased()->Bool {
        
        return getUserDefaultBoolValue(ProductID)
        
    }
    
    static func Purchase() {
        SwiftyStoreKit.retrieveProductsInfo([ProductID]) { result in
            if let _ = result.retrievedProducts.first {
                
                SwiftyStoreKit.purchaseProduct(ProductID, atomically: true) { result in
                    switch result {
                    case .success:
                        Toast(text: "구매 성공!").show()
                        setUserDefaultWithBool(true, forKey: ProductID)
                    case .error:
                        Toast(text: "결제 중 오류가 발생했습니다.").show()
                    }
                }
                
            }else { Toast(text: "결제 중 오류가 발생했습니다.").show() }
        }
    }
    
}

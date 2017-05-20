//
//  RESideLeftViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 27/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import FBSDKLoginKit

final class RESideLeftViewModel {
    
    func numberOfMenuItem() -> Int {
        return MenuItem.count
    }
    
    func performLogout(completion: (_ success: Bool, _ error: String?) -> Void) {
        FirebaseProxy.sharedInstance.signOut { (success, error) in
            if let errorMessage = error {
                Log.error(errorMessage)
            }
            
            FBSDKAccessToken.setCurrent(nil)
            FBSDKProfile.setCurrent(nil)
            completion(success, error)
        }
        
    }
}

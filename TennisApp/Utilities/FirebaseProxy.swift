//
//  FirebaseProxy.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseProxy {
    
    static let sharedInstance : FirebaseProxy = {
        let instance = FirebaseProxy()
        return instance
    }()
    
    var currentUser: FIRUser? = nil
    
    // MARK: Methods
    
    init() {
        FIRApp.configure()
        self.currentUser = FIRAuth.auth()?.currentUser
    }
    
    
    /// Set the user, send a notification and redirect to Main storyboard
    ///
    /// - Parameter user: The logged user
    func signedIn(_ user: FIRUser?) {
        self.currentUser = user
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        AppDelegate.instance().setRootViewController(Utils.getControllerFromStoryboard("Main"))
    }
    
    func signOut(completion: (_ success: Bool, _ error: String?) -> Void) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            completion(true, nil)
            self.currentUser = nil
        } catch let signOutError as NSError {
            completion(false, signOutError.localizedDescription)
            Log.error("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

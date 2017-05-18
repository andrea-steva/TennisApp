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

    static let sharedInstance: FirebaseProxy = {
        return FirebaseProxy()
    }()

    var currentUser: FIRUser?

    // MARK: Methods

    init() {
        FIRApp.configure()
        self.currentUser = FIRAuth.auth()?.currentUser
    }

    func signedIn(_ user: FIRUser?) {
        self.currentUser = user
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
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

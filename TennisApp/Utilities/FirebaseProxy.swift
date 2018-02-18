//
//  FirebaseProxy.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Firebase
import Foundation

final class FirebaseProxy {

    static let sharedInstance: FirebaseProxy = { FirebaseProxy() }()

    var currentUser: Firebase.User?

    // MARK: Methods

    init() {
        FirebaseApp.configure()
        currentUser = Auth.auth().currentUser
    }

    func signedIn(_ user: Firebase.User?) {
        currentUser = user
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
    }

    func signOut(completion: (_ success: Bool, _ error: String?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(true, nil)
            self.currentUser = nil
        } catch let signOutError as NSError {
            completion(false, signOutError.localizedDescription)
            Log.error("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

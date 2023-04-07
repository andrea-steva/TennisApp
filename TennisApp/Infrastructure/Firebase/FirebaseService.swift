//
//  FirebaseService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Firebase
import Foundation

final class FirebaseService {

    struct NotificationKeys {
        static let signedIn = "signed_in"
    }

    // MARK: Shared instance

    static let shared: FirebaseService = { FirebaseService() }()

    // MARK: Properties

    var currentUser: Firebase.User?

    // MARK: Methods

    private init() {
        FirebaseApp.configure()
        currentUser = Auth.auth().currentUser
    }

    private func postSignedIn() {
        let notificationName = Notification.Name(rawValue: FirebaseService.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
    }

    func createUser(withEmail email: String, password: String,
                    completion: @escaping (Result<FirebaseUser, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            guard let user = response?.user else {
                completion(.failure(FirebaseError.error))
                return
            }
            self.currentUser = user
            let firebaseUser = FirebaseUser(providerID: user.providerID,
                                            displayName: user.displayName,
                                            photoURL: user.photoURL,
                                            email: user.email)
            completion(.success(firebaseUser))
            self.postSignedIn()
        }
    }

    func signOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success(true))
            self.currentUser = nil
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }

    func signIn(withEmail email: String, password: String,
                completion: @escaping (Result<URL, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error {
                completion(.failure(error))
                return
            }
            if let profileImageURL = result?.user.photoURL {
                completion(.success(profileImageURL))
            } else {
                completion(.failure(FirebaseError.error))
            }
            self.currentUser = result?.user
            self.postSignedIn()
        }
    }

    func sendPasswordReset(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }

    func createProfileChangeRequest(user: FirebaseUser,
                                    completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUser else {
            completion(.failure(FirebaseError.error))
            return
        }

        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = user.displayName
        changeRequest.commitChanges { error in
            if let error {
                completion(.failure(error))
                return
            }
            self.postSignedIn()
            completion(.success(true))
        }
    }
}

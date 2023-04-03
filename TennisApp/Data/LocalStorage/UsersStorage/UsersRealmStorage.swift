//
//  UsersRealmStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

final class UsersRealmStorage: UsersLocalStorage {
    
    private var storage: StorageContext?
    
    init() {
        self.storage = try? RealmStorageContext(configuration: ConfigurationType.basic(identifier: "tennis_db"))
    }
    
    func fetchUsers(block: @escaping (_ users: [UserEntity]) -> Void) {
        self.storage?.fetch(UserEntity.self, predicate: nil, sorted: nil, completion: { (users) in
            block(users)
        })
    }
    
    func createUser(user: UserEntity) {
        do {
            try self.storage?.create(object: user, completion: { (user) in
            })
        } catch _ as NSError {
        }
    }
    
    func updateUser(block: @escaping () -> Void) {
        do {
            try self.storage?.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
    
    func deleteUser(user: UserEntity) {
        do {
            try self.storage?.delete(object: user)
        } catch _ as NSError {
        }
    }
}

//
//  UsersService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol UsersServiceProtocol {
    func fetchUsers(block: @escaping (_ users: [User]) -> Void)
    func createUser(user: User)
    func updateUser(block: @escaping () -> Void)
    func deleteUser(user: User)

}

final class UsersService: UsersServiceProtocol {
    
    fileprivate var storage: StorageContext?
    
    init() {
        self.storage = try! RealmStorageContext(configuration: ConfigurationType.basic(identifier: "tennis_db"))
    }
    
    func fetchUsers(block: @escaping (_ users: [User]) -> Void) {
        self.storage?.fetch(User.self, predicate: nil, sorted: nil, completion: { (users) in
            block(users)
        })
    }
    
    func createUser(user: User) {
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
    
    func deleteUser(user: User) {
        do {
            try self.storage?.delete(object: user)
        } catch _ as NSError {
        }
    }
}

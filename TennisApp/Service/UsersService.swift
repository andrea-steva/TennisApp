//
//  UsersService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 25/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import RealmSwift

protocol UsersServiceProtocol {
    func fetchUsers() -> Results<User>
    func saveUser(user: User, saveBlock: ((_ user: User) -> Void)?)
    func deleteUser(user: User)
}

final class UsersService: UsersServiceProtocol {
    
    func fetchUsers() -> Results<User> {
        let users = RealmProxy().getAllObjects() as Results<User>
        return users
    }
    
    func deleteUser(user: User) {
        RealmProxy().deleteObject(user) { (user) in
        }
    }
    
    func saveUser(user: User, saveBlock: ((_ user: User) -> Void)?) {
        RealmProxy().saveObject(user) { (user) in
            saveBlock?(user)
        }
    }
}

final class UsersRepo {
    
    private let users: Results<User>
    private let service: UsersServiceProtocol
    
    init(usersService: UsersServiceProtocol) {
        self.service = usersService
        self.users = usersService.fetchUsers()
    }
    
    func getUsers() -> Results<User> {
        return users
    }
    
    func deleteUser(user: User) {
        self.service.deleteUser(user: user)
    }
    
    func saveUser(user: User, saveBlock: ((_ user: User) -> Void)? = nil) {
        self.service.saveUser(user: user, saveBlock: saveBlock)
    }
}

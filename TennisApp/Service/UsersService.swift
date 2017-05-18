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
    func fetchUsers() -> Results<TUser>
    func saveUser(user: TUser, saveBlock: ((_ user: TUser) -> Void)?)
    func deleteUser(user: TUser)
}

final class UsersService: UsersServiceProtocol {
    
    func fetchUsers() -> Results<TUser> {
        let users = RealmProxy().getAllObjects() as Results<TUser>
        return users
    }
    
    func deleteUser(user: TUser) {
        RealmProxy().deleteObject(user) { (user) in
        }
    }
    
    func saveUser(user: TUser, saveBlock: ((_ user: TUser) -> Void)?) {
        RealmProxy().saveObject(user) { (user) in
            saveBlock?(user)
        }
    }
}

final class UsersRepo {
    
    private let users: Results<TUser>
    private let service: UsersServiceProtocol
    
    init(usersService: UsersServiceProtocol) {
        self.service = usersService
        self.users = usersService.fetchUsers()
    }
    
    func getUsers() -> Results<TUser> {
        return users
    }
    
    func deleteUser(user: TUser) {
        self.service.deleteUser(user: user)
    }
    
    func saveUser(user: TUser, saveBlock: ((_ user: TUser) -> Void)? = nil) {
        self.service.saveUser(user: user, saveBlock: saveBlock)
    }
}

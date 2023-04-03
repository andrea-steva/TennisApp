//
//  UsersStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol UsersLocalStorage {
    func fetchUsers(block: @escaping (_ users: [UserEntity]) -> Void)
    func createUser(user: UserEntity)
    func updateUser(block: @escaping () -> Void)
    func deleteUser(user: UserEntity)

}

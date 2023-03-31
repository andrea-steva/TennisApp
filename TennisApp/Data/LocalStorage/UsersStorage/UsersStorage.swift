//
//  UsersStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol UsersStorage {
    func fetchUsers(block: @escaping (_ users: [User]) -> Void)
    func createUser(user: User)
    func updateUser(block: @escaping () -> Void)
    func deleteUser(user: User)

}

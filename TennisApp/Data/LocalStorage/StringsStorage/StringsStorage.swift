//
//  StringsStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringsStorage {
    func fetchStrings(block: @escaping (_ strings: [Strings]) -> Void)
    func createString(string: Strings)
    func updateString(block: @escaping () -> Void)
    func deleteString(string: Strings)
}

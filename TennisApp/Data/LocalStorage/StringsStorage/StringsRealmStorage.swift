//
//  StringsRealmStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation

final class StringsRealmStorage: StringsStorage {
    
    private var storage: StorageContext?
    
    init() {
        self.storage = try? RealmStorageContext(configuration: ConfigurationType.basic(identifier: "tennis_db"))
    }
    
    func fetchStrings(block: @escaping (_ strings: [StringsEntity]) -> Void) {
        let sort = Sorted(key: "manufacter", ascending: false)
        self.storage?.fetch(StringsEntity.self, predicate: nil, sorted: sort, completion: { (strings) in
            block(strings)
        })
    }
    
    func createString(string: StringsEntity) {
        do {
            try self.storage?.create(object: string, completion: { (string) in
            })
        } catch _ as NSError {
        }
    }
    
    func updateString(block: @escaping () -> Void) {
        do {
            try self.storage?.update(block: {
                block()
            })
        } catch _ as NSError {
        }
    }
    
    func deleteString(string: StringsEntity) {
        do {
            try self.storage?.delete(object: string)
        } catch _ as NSError {
        }
    }
}

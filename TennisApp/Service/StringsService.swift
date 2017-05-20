//
//  StringsService.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import RealmSwift

protocol StringsServiceProtocol {
    func fetchStrings() -> Results<Strings>
    func saveString(string: Strings, saveBlock: ((_ string: Strings) -> Void)?)
    func deleteString(string: Strings)
}

final class StringsService: StringsServiceProtocol {
    
    func fetchStrings() -> Results<Strings> {
        let string = RealmProxy().getAllObjects(sortedBy: "manufacter") as Results<Strings>
        return string
    }
    
    func deleteString(string: Strings) {
        RealmProxy().deleteObject(string) { (string) in
        }
    }
    
    func saveString(string: Strings, saveBlock: ((_ string: Strings) -> Void)?) {
        RealmProxy().saveObject(string) { (string) in
            saveBlock?(string)
        }
    }
}

final class StringsRepo {
    
    private let strings: Results<Strings>
    private let service: StringsServiceProtocol
    
    init(stringsService: StringsServiceProtocol) {
        self.service = stringsService
        self.strings = stringsService.fetchStrings()
    }
    
    func getStrings() -> Results<Strings> {
        return strings
    }
    
    func deleteString(string: Strings) {
        self.service.deleteString(string: string)
    }
    
    func saveString(string: Strings, saveBlock: ((_ string: Strings) -> Void)? = nil) {
        self.service.saveString(string: string, saveBlock: saveBlock)
    }
}

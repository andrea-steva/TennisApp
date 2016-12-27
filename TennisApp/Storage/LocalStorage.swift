//
//  LocalStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

class LocalStorage: RealmProxy {

    func getUser() -> [User] {
        return self.getAllObjects()
    }

    func getRackets() -> [Racket] {
        return self.getAllObjects(sortedBy: "purchasedDate")
    }

}

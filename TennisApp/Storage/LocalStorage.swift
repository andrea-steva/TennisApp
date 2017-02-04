//
//  LocalStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

class LocalStorage: RealmProxy {

    // MARK: User

    func getUser() -> Results<User> {
        return self.getAllObjects()
    }

    // MARK: Rackets

    func getRackets() -> Results<Racket> {
        return self.getAllObjects(sortedBy: "purchaseDate")
    }

    func saveRacket(racket: Racket, saveBlock: ((_ racket: Racket) -> Void)?) {
        self.saveObject(racket) { (racket) in
            saveBlock?(racket)
        }
    }

    func deleteRacket(racket: Racket) {
        self.deleteObject(racket) { (racket) in
        }
    }
}

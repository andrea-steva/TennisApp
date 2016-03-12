//
//  TNDao.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//


class TNDao: RealmDao {
    
    func getUser() -> [TNUser] {
        return self.getAllObjects()
    }
    
    func getRackets() -> [TNRacket] {
        return self.getAllObjects(sortedBy: "purchasedDate")
    }
    
}

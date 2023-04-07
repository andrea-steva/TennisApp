//
//  UserEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreData

//    // MARK: Relationship
//
//    @Persisted var rackets = List<RacketEntity>()
//    @Persisted var matches = List<MatchEntity>()
//    @Persisted var fitness = List<FitnessEntity>()
//    @Persisted var practices = List<PracticeEntity>()
//

// MARK: - Mappings to domain

extension UserEntity {

    func toDomain() -> User {
        User(identifier: self.identifier ?? "",
             firstName: self.firstName ?? "",
             lastName: self.lastName ?? "",
             age: Int(self.age),
             email: self.email ?? "",
             backhandType: self.backhandType ?? "",
             handType: self.handType ?? "",
             ranking: self.ranking ?? "",
             profileImage: self.profileImage)
    }
}

extension UserEntity {
    convenience init(user: User, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        identifier = user.identifier
        firstName = user.firstName
        lastName = user.lastName
        age = Int32(user.age)
        email = user.email
        backhandType = user.backhandType
        handType = user.handType
        ranking = user.ranking
        profileImage = user.profileImage
    }
}

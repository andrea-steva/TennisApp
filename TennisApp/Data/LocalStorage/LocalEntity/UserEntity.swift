//
//  UserEntity.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Realm
import RealmSwift

final class UserEntity: Object {
    
    // MARK: Stored Attributes
    
    @Persisted(primaryKey: true) var userId: ObjectId
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var age: Int
    @Persisted var email: String = ""
    @Persisted var phoneNumber: String = ""
    @Persisted var profileImage: Data!

    @Persisted var handType: String = ""
    @Persisted var backhandType: String = ""

    @Persisted var ranking: String = ""
    
    // MARK: Relationship

    @Persisted var rackets = List<RacketEntity>()
    @Persisted var matches = List<MatchEntity>()
    @Persisted var fitness = List<FitnessEntity>()
    @Persisted var practices = List<PracticeEntity>()
        
    // MARK: Init
    
    required init(_ dictionary: [String: Any?]) {
        super.init()
        self.mapping(dictionary)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    // MARK: Class Methods
    
    func updateFrom(dictionary: [String: Any?]) {
        self.mapping(dictionary)
    }
    
    fileprivate func mapping(_ dictionary: [String: Any?]) {
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
    }
}

// MARK: - Mappings to domain

extension UserEntity {

    func toDomain() -> User {
        .init(firstName: self.firstName ?? "",
              lastName: self.lastName ?? "",
              age: self.age,
              email: self.email,
              phoneNumber: self.phoneNumber)
    }
}


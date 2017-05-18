//
//  RealmProxy.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

final class RealmProxy {
    
    /** The Realm object. */
    fileprivate var realm: Realm!
    
    fileprivate let databaseName: String = "tennis_db"
    
    // MARK: Init
    
    init(injectedRealm: Realm? = nil) {
        if let injectedRealm = injectedRealm {
            self.realm = injectedRealm
        } else {
            self.realm = setupRealm()
        }
        if self.realm == nil {
            fatalError("Cannot initialize Realm")
        }
    }
    
    fileprivate func setupRealm() -> Realm! {
        
        //Set the realm database file with name "tennis_db.realm"
        let realmConfiguration = Realm.Configuration()
        guard let path = realmConfiguration.fileURL?.absoluteString else {
            return nil
        }
        
        let realmPath = NSURL.fileURL(withPath: path)
            .deletingLastPathComponent()
            .appendingPathComponent(databaseName)
            .appendingPathExtension("realm")
        
        let schemaVersion: UInt64 = 0
        
        let config = Realm.Configuration(fileURL: realmPath, schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < schemaVersion) {
                Log.debug("---- Perform Migration block ----")
                Log.debug("Old schema version: \(oldSchemaVersion)")
                Log.debug("Current schema version: \(schemaVersion)")
            }
        })
        
        let realm = try! Realm(configuration: config)
        
        Log.debug("Realm DB path: \(realm.configuration.fileURL?.absoluteString ?? "")")
        Log.debug("Current schema version: \(realm.configuration.schemaVersion)")
        
        return realm
    }
    
    // MARK: Save
    
    /**
     Save an object in the storage.
     
     - parameter object: The object to save, if nil it will be created.
     */
    internal func saveObject<O: Object>(_ object: O, saveBlock : ((_ object: O) -> Void)?) {
        self.saveObjects([object], saveBlock: saveBlock)
    }
    
    /**
     Save a list of objects in the storage.
     
     - parameter objects: The list of objects to save.
     */
    internal func saveObjects<O: Object>(_ objects: [O], saveBlock : ((_ object: O) -> Void)?) {
        write { () -> Void in
            for object in objects {
                if let saveBlock  = saveBlock {
                    saveBlock(object)
                }
                self.realm.create(O.self, value: object, update: true)
            }
        }
    }
    
    // MARK: Get
    
    /**
     Get an object from the storage given its id.
     
     - parameter id: The object's id.
     - return: The object if exists.
     */
    internal func getObjectByPrimaryKey<O: Object>(key: String) -> O? {
        return self.realm.object(ofType: O.self, forPrimaryKey: key)
    }
        
    /**
     Get an object from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The object if exists.
     */
    internal func getObject<O: Object>(_ predicate: String) -> O? {
        return self.realm.objects(O.self).filter(predicate).first
    }
    
    /**
     Get a list of objects from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The objects list.
     */
    internal func getObjects<O: Object>(_ predicate: String) -> Results<O> {
        return self.realm.objects(O.self).filter(predicate)
    }
    
    /**
     Get a list of objects from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The objects list.
     */
    internal func getObjects<O: Object>(_ predicate: String, sortBy: String) -> Results<O> {
        return self.realm.objects(O.self).filter(predicate).sorted(byKeyPath: sortBy)
    }
    
    /**
     Get all the objects from the storage.
     
     - return: The objects list.
     */
    internal func getAllObjects<O: Object>() -> Results<O> {
        return self.realm.objects(O.self)
    }
    
    /**
     Get all the objects from the storage.
     
     - return: The objects list.
     */
    internal func getAllObjects<O: Object>(sortedBy: String) -> Results<O> {
        return self.realm.objects(O.self).sorted(byKeyPath: sortedBy, ascending: false)
    }
    
    // MARK: Delete
    
    /**
     Delete an object from the storage.
     
     - parameter object: The object to delete.
     */
    internal func deleteObject<O: Object>(_ object: O, deleteBlock : ((_ object: O) -> Void)?) {
        self.deleteObjects([object], deleteBlock: deleteBlock)
    }
    
    /**
     Delete a list of objects from the storage.
     
     - parameter object: The list of objects to delete.
     */
    internal func deleteObjects<O: Object>(_ objects: [O], deleteBlock : ((_ object: O) -> Void)?) {
        write { () -> Void in
            for object in objects {
                if let deleteBlock  = deleteBlock {
                    deleteBlock(object)
                }
                self.realm.delete(object)
            }
        }
    }
    
    /**
     Writes changes on the storage.
     
     - parameter block: The block containing the changes to apply.
     */
    fileprivate func write(_ block : () -> Void) {
        do {
            try self.realm.write(block)
        } catch {
            Log.debug("Error writing on storage.")
        }
    }
}

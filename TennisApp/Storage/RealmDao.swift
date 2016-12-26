//
//  RealmDao.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import RealmSwift

class RealmDao {

    /** The Realm object. */
    fileprivate var realm: Realm!

    // MARK: Init

    init() {
        self.setupRealm()
    }

    fileprivate func setupRealm() {

        //Set the realm database file with name "tennis_db.realm"
        let realmConfiguration = Realm.Configuration()
        guard let path = realmConfiguration.fileURL?.absoluteString else {
            return
        }

        let realmPath = NSURL.fileURL(withPath: path)
            .deletingLastPathComponent()
            .appendingPathComponent("tennis_db")
            .appendingPathExtension("realm")

        //When you change Realm objects you need to increase the schemaVersion to perform the migration.
        //Increase this number when you change the schema of your database
        let schemaVersion: UInt64 = 0

        let config = Realm.Configuration(fileURL: realmPath, schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < schemaVersion) {
                Log.debug("---- Perform Migration block ----")
                Log.debug("Old schema version: \(oldSchemaVersion)")
                Log.debug("Current schema version: \(schemaVersion)")
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        })

        realm = try! Realm(configuration: config)

        Log.debug("Realm DB path: \(realm.configuration.fileURL?.absoluteString)")
        Log.debug("Current schema version: \(realm.configuration.schemaVersion)")
    }

    // MARK: Save

    /**
    Save an object in the storage.
    
    - parameter object: The object to save, if nil it will be created.
    */
    func saveObject<O: Object>(_ object: O, saveBlock : ((_ object: O) -> Void)?) {
        self.saveObjects([object], saveBlock: saveBlock)
    }

    /**
     Save a list of objects in the storage.
     
     - parameter objects: The list of objects to save.
     */
    func saveObjects<O: Object>(_ objects: [O], saveBlock : ((_ object: O) -> Void)?) {
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
    func getObjectByPrimaryKey<O: Object>(_ primaryKeyValue: String) -> O? {
        let primaryKey = O.primaryKey()!
        return self.getObject("\(primaryKey) == '\(primaryKeyValue)'")
    }

    /**
     Get an object from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The object if exists.
     */
    func getObject<O: Object>(_ predicate: NSPredicate) -> O? {
        return self.realm.objects(O.self).filter(predicate).first
    }

    /**
     Get an object from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The object if exists.
     */
    func getObject<O: Object>(_ predicate: String) -> O? {
        return self.realm.objects(O.self).filter(predicate).first
    }

    /**
     Get a list of objects from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The objects list.
     */
    func getObjects<O: Object>(_ predicate: NSPredicate) -> [O] {
        return self.realm.objects(O.self).filter(predicate).toArray(O.self)
    }

    /**
     Get a list of objects from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The objects list.
     */
    func getObjects<O: Object>(_ predicate: String) -> [O] {
        return self.realm.objects(O.self).filter(predicate).toArray(O.self)
    }

    /**
     Get a list of objects from the storage given a predicate.
     
     - parameter predicate: The predicate used to filter.
     - return: The objects list.
     */
    func getObjects<O: Object>(_ predicate: String, sortBy: String) -> [O] {
        return self.realm.objects(O.self).filter(predicate).sorted(byProperty: sortBy).toArray(O.self)
    }

    /**
     Get a list of objects paginated from the storage, sorted by a given property
     
     - parameter sortedBy:  The property name to sort by.
     - parameter ascending: The direction to sort by.
     - parameter page:      The page.
     - parameter pageSize:  The pageSize.
     
     - returns: The objects list.
     */
    func getObjects<O: Object>(_ predicate: String, sortedBy: String, page: Int, pageSize: Int) -> [O] {
        return self.realm.objects(O.self).filter(predicate).sorted(byProperty: sortedBy).toArray(O.self, page : page, pageSize : pageSize)
    }

    /**
     Get all the objects from the storage.
     
     - return: The objects list.
     */
    func getAllObjects<O: Object>() -> [O] {
        return self.realm.objects(O.self).toArray(O.self)
    }

    /**
     Get all the objects from the storage.
     
     - return: The objects list.
     */
    func getAllObjects<O: Object>(sortedBy: String) -> [O] {
        return self.realm.objects(O.self).sorted(byProperty: sortedBy, ascending: false).toArray(O.self)
    }

    // MARK: Delete

    /**
    Delete an object from the storage.
    
    - parameter object: The object to delete.
    */
    func deleteObject<O: Object>(_ object: O, deleteBlock : ((_ object: O) -> Void)?) {
        self.deleteObjects([object], deleteBlock: deleteBlock)
    }

    /**
     Delete a list of objects from the storage.
     
     - parameter object: The list of objects to delete.
     */
    func deleteObjects<O: Object>(_ objects: [O], deleteBlock : ((_ object: O) -> Void)?) {
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
    func write(_ block : () -> Void) {
        do {
            try self.realm.write(block)
        } catch {
            Log.debug("Error writing on storage.")
        }
    }

}

extension Results {

    func toArray<T>(_ ofType: T.Type) -> [T] {
        return toArray(T.self, page : 1, pageSize : self.count)
    }

    func toArray<T>(_ ofType: T.Type, page: Int, pageSize: Int) -> [T] {
        var array = [T]()
        var i = (page - 1) * pageSize
        if i >= self.count {
            return []
        }

        while i < page * pageSize && i < self.count {
            if let result = self[i] as? T {
                array.append(result)
            }
            i += 1
        }
        return array
    }

}

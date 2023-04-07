//
//  CoreDataStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

class CoreDataStorage {

    let modelName: String

    init(modelName: String = "AppCoreDataModel") {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { _, error  in
            if let error {
                assertionFailure("CoreDataStorage Error: \(error.localizedDescription)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    func saveContext() throws {
        guard managedContext.hasChanges else { return }

        try managedContext.save()
    }
}

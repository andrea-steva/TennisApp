//
//  CoreDataStorageMock.swift
//  TennisAppTests
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation
@testable import TennisApp

class CoreDataStorageMock: CoreDataStorage {

    override init(modelName: String) {
        super.init(modelName: modelName)

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")

        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { _, _ in }

        persistentContainer = container
    }
}

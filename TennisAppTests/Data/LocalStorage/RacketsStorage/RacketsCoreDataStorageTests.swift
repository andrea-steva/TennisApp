//
//  RacketsCoreDataStorageTests.swift
//  TennisAppTests
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

@testable import TennisApp
import XCTest

final class RacketsCoreDataStorageTests: XCTestCase {

    // MARK: Save and fetch

    func test_saveAndFetchUsers_CoreData() {
        let expectation = expectation(description: "CoreData expectation")

        let storage = getRacketsCoreDataStorageMock()
        storage.save(rackets: getStubRackets(10)) { result in
            if case .success(let success) = result {
                XCTAssertTrue(success)

                storage.fetch { result in
                    if case .success(let rackets) = result {
                        XCTAssertEqual(rackets.count, 10)

                        guard let racket = rackets.first(where: { $0.identifier == "0" }) else {
                            XCTFail("Cannot retrieve racket")
                            return
                        }
                        XCTAssertEqual(racket.identifier, "0")
                        XCTAssertEqual(racket.manufacter, "Manufacter 0")
                        XCTAssertEqual(racket.model, "Model 0")
                        XCTAssertEqual(racket.weight, 340)
                        XCTAssertEqual(racket.gripSize, .three)
                        XCTAssertNotNil(racket.image)
                        XCTAssertNotNil(racket.purchaseDate)
                        XCTAssertEqual(racket.sport, .tennis)
                        XCTAssertEqual(racket.price, 200, accuracy: 0.01)

                        expectation.fulfill()
                    }
                }
            }
        }
        self.waitForExpectations(timeout: TennisAppTests.expectationStandardTimeout)
    }
}

private extension RacketsCoreDataStorageTests {

    /// Create stub users for tests
    /// - Parameter count: The number of users to create
    /// - Returns: An array of stub users
    func getStubRackets(_ count: Int = 10) -> [Racket] {
        Array(0..<count).map { index -> Racket in
            Racket(identifier: "\(index)",
                   manufacter: "Manufacter \(index)",
                   model: "Model \(index)",
                   weight: 340,
                   gripSize: .three,
                   image: Data(repeating: 0, count: 10),
                   purchaseDate: Date(),
                   sport: .tennis,
                   price: 200)
        }
    }

    /// Get a mock data storage
    func getRacketsCoreDataStorageMock() -> RacketsCoreDataStorage {
        let coreDataStorage = CoreDataStorageMock(modelName: "AppCoreDataModel")
        return RacketsCoreDataStorage(coreDataStorage: coreDataStorage)
    }
}

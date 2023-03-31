//
//  RacketsStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketsStorage {
    func fetchRackets(block: @escaping (_ rackets: [Racket]) -> Void)
    func createRacket(racket: Racket)
    func updateRacket(block: @escaping () -> Void)
    func deleteRacket(racket: Racket)
}

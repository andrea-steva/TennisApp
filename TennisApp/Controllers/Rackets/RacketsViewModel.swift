//
//  RacketsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

class RacketsViewModel: BaseViewModel {

    fileprivate let dataAccess = LocalStorage()

    func getRacket(forIndex index: Int) -> Racket {
        let rackets = dataAccess.getRackets()
        return rackets[index]
    }

    func getRacketsCount() -> Int {
        return dataAccess.getRackets().count
    }

}

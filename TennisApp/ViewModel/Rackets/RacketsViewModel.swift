//
//  RacketsViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 14/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

class RacketsViewModel: BaseViewModel {
    
    private let dao = RacketDao()
    
    func getRacket(forIndex index: Int) -> TNRacket {
        let rackets = dao.getRackets()
        return rackets[index]
    }
    
    func getRacketsCount() -> Int {
        return dao.getRackets().count
    }

}

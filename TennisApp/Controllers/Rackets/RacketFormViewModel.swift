//
//  RacketFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RealmSwift

class RacketFormViewModel: BaseViewModel {
    
    // MARK: Properties
    
    fileprivate let localStorage = LocalStorage()
    
    var newRacket: Bool = true
    var racket: Racket?
    
    // MARK: Methods
    
    override init() {
        
    }
    
    func creareOrUpdateRacket(formValues: [String: Any?]) {
        //Create the new racket if necessary
        if self.newRacket {
            self.racket = Racket()
            self.racket!.racketId = UUID().uuidString
        }
        
        //Update racket
        if let racket = self.racket {
            self.localStorage.saveRacket(racket: racket, saveBlock: { (racket) in
                racket.updateFrom(dict: formValues)
            })
        }
    }
}

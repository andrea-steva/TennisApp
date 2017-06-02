//
//  StringFormViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/01/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RealmSwift

final class StringFormViewModel: BaseViewModel {

    // MARK: Properties

    fileprivate let stringsRepo = StringsRepo(stringsService: StringsService())

    var newStrings: Bool = true
    var string: Strings?

    // MARK: Methods

    override init() {

    }

    func creareOrUpdateString(formValues: [String: Any?]) {
        //Create the new string if necessary
        if newStrings {
            string = Strings()
            string!.stringId = UUID().uuidString
        }

        //Update string
        if let string = self.string {
            self.stringsRepo.saveString(string: string, saveBlock: { (string) in
                string.updateFrom(dict: formValues)
            })
        }
    }
}

//
//  RacketFormViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Eureka

class RacketFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizedString.rackets_addRacket)

        form +++ Section("Custom cells")
            <<< IntRow("IntRow1") { $0.title = "Int 1"; $0.value = 1 }
            <<< IntRow("IntRow2") { $0.title = "Int 2"; $0.value = 2 }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

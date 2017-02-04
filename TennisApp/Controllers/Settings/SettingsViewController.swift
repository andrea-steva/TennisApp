//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Tamamushi

class SettingsViewController: BaseViewController {

    // MARK: IBAction

    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_settings
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: self.navigationController!.navigationBar, direction: .vertical,
                                                                  startColor: Style.Colors.courtHardP,
                                                                  endColor: Style.Colors.courtHardP.lighter())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

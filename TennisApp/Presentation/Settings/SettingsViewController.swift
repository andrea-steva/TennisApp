//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit


final class SettingsViewController: BaseViewController, StoryboardInstantiable {

    // MARK: IBAction

    // MARK: ViewModel
    
    var viewModel: SettingsViewModel!
    
    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_settings
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

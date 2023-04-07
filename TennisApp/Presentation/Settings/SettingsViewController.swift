//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SettingsViewController: BaseViewController, StoryboardInstantiable {

    // MARK: IBActions

    // MARK: ViewModel

    var viewModel: SettingsViewModel!

    // MARK: View Management

    override func localizedTitleString() -> String {
        LocalizationKeys.menuSettings
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Logout

    func sideMenuUserLogout() {
        AlertView.showConfirm(localizer.get(LocalizationKeys.genericAlertTitle),
                              message: "Are you sure to want to logout?") { [weak self] (userCancelAction) in
            guard let self else { return }
            if !userCancelAction {
                self.viewModel.performLogout(completion: { (_, _) in
                    self.viewModel.userDidlogout()
                })
            }
        }
    }
}

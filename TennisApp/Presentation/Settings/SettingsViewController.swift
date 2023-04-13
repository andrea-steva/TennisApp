//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, StoryboardInstantiable,
                                    UITableViewDataSource, UITableViewDelegate,
                                    BackgroundBlurrable, Localizable, Alertable {

    // MARK: IBActions

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: SettingsViewModelType!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.menuSettings)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.setBackgroundBlurEffect()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: SettingsTableViewCell.reuseIdentifier)

        let settings = viewModel.getSettingsFor(index: indexPath.row)
        cell.backgroundColor = .clear
        cell.textLabel?.text = settings.title

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfSettings()
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let settings = viewModel.getSettingsFor(index: indexPath.row)
        switch settings {
        case .general:
            break
        case .support:
            break
        case .logout:
            performLogout()
        }
    }

    // MARK: Logout

    private func performLogout() {
        self.showAlert(title: localizer.get(LocalizationKeys.genericAlertTitle),
                       message: "Are you sure to want to logout?",
                       confirmAction: { _ in
            self.viewModel.performLogout(completion: nil)
        })
    }
}

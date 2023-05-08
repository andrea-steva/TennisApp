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
        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        self.setBackgroundBlurEffect()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = buildFooterView()
    }

    private func buildFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        footerView.backgroundColor = UIColor.clear
        let footerLabel = UILabel(frame: CGRect(x: 20, y: 0, width: footerView.frame.width, height: 40))
        footerLabel.numberOfLines = 2
        footerLabel.backgroundColor = UIColor.clear
        footerLabel.textColor = Colors.lightColor
        footerLabel.font = Fonts.get(.light, size: .normal)
        footerLabel.text = viewModel.getFooterText()
        footerView.addSubview(footerLabel)
        return footerView
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SettingsTableViewCell else {
            assertionFailure("Cannot dequeue SettingsTableViewCell")
            return UITableViewCell()
        }
        let settings = viewModel.getSettingsFor(index: indexPath.row)
        cell.setup(settings: settings)
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
        case .review:
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

//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,
                                   StoryboardInstantiable, BackgroundBlurrable, Localizable {

    static let ProfileCellReuseId = "profile_cell"

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: ProfileViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.menuProfile)
        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        self.setBackgroundBlurEffect()

        if let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as? ProfileHeaderView {
            self.tableView.addSubview(headerView)
        }
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.ProfileCellReuseId, for: indexPath)
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

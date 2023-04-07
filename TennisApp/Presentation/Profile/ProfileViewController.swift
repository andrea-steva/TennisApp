//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class ProfileViewController: BaseViewController, UITableViewDataSource, UITabBarDelegate, StoryboardInstantiable {

    static let ProfileCellReuseId = "profile_cell"

    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: ViewModel

    var viewModel: ProfileViewModel!

    // MARK: View Management

    override func localizedTitleString() -> String {
        LocalizationKeys.menuProfile
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

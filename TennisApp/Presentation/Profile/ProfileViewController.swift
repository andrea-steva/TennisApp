//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class ProfileViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,
                                   StoryboardInstantiable, BackgroundBlurrable {

    static let ProfileCellReuseId = "profile_cell"

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    private(set) var subscriptions = Set<AnyCancellable>()
    private var headerView: ProfileHeaderView?
    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: ViewModel

    var viewModel: ProfileViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.profileBackground)
        self.title = Localization.Menu.profile

        self.setBackgroundBlurEffect()

        self.setupObservers()

        if let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as? ProfileHeaderView {
            self.headerView = headerView
            self.tableView.addSubview(headerView)
        }

        viewModel.fetchPrimaryUser()
    }

    private func setupObservers() {
        viewModel.reloadViewData
            .sink(receiveCompletion: { _ in
                // Handle the error
            }, receiveValue: { [weak self] _ in
                if let userViewModel = self?.viewModel.getUserViewModel() {
                    self?.headerView?.setup(with: userViewModel)
                }
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
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

//
//  RacketsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class RacketsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                                   StoryboardInstantiable, BackgroundBlurrable, Localizable, Alertable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    private(set) var subscriptions = Set<AnyCancellable>()
    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: RacketsViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.menuRackets)
        self.navigationItem.rightBarButtonItems = setupRightBarButtonItem()

        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        self.setBackgroundBlurEffect()
        self.setupObservers()
        self.addPullToRefresh()

        self.viewModel.fetchRackets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupRightBarButtonItem() -> [UIBarButtonItem] {
        let buttons = [
            UIBarButtonItem(title: "Add Racket", style: .plain, target: self, action: #selector(didTapOnAddRacketButton)),
            UIBarButtonItem(title: "Strings", style: .plain, target: self, action: #selector(didTapOnStringsButton))
        ]
        return buttons
    }

    private func setupObservers() {
        viewModel.reloadViewData
            .sink(receiveCompletion: { _ in
                // Handle the error
            }, receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            })
            .store(in: &subscriptions)
    }

    // MARK: Refresh Control

    private func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }

    @objc private func pullToRefreshAction(_ sender: AnyObject) {
        self.viewModel.fetchRackets()
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let racketsCount = viewModel.numberOfRackets()
        if racketsCount == 0 {
            self.tableView.setEmptyMessage("No rackets saved")
        } else {
            self.tableView.restore()
        }
        return racketsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RacketTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? RacketTableViewCell else {
            assertionFailure("Cannot dequeue RacketTableViewCell")
            return UITableViewCell()
        }
        cell.setup(with: viewModel.getRacket(forIndex: indexPath.row))
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.5
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        if section == 0 {
            footerView.backgroundColor = Colors.grayColor
        }
        return footerView
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            self.viewModel.toRacketForm(index: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = Colors.primaryColor

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
            self.showAlert(title: self.localizer.get(LocalizationKeys.genericAlertTitle),
                           message: "Are you sure to delete the racket?",
                           confirmAction: { _ in
                self.viewModel.deleteRacket(forIndex: indexPath.row)
                self.tableView.setEditing(false, animated: true)
            })
        }

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    // MARK: IBActions

    @IBAction private func didTapOnStringsButton(_ sender: AnyObject) {
        self.viewModel.toStrings()
    }

    @IBAction private func didTapOnAddRacketButton(_ sender: AnyObject) {
        self.viewModel.toEmptyRacketForm()
    }
}

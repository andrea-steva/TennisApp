//
//  StringsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class StringsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                                   StoryboardInstantiable, Localizable, Alertable, BackgroundBlurrable {

    static let StringsCellReuseId = "string_cell"

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    private(set) var subscriptions = Set<AnyCancellable>()
    let localizer = Localizer()

    // MARK: ViewModel

    var viewModel: StringsViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = localizer.get(LocalizationKeys.menuStrings)
        self.navigationItem.rightBarButtonItems = setupRightBarButtonItem()

        self.navigationController?.navigationBar.scrollEdgeAppearance = Style.getUINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = Style.getUINavigationBarAppearance()

        self.setBackgroundBlurEffect()
        self.setupObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchStrings()
    }

    private func setupRightBarButtonItem() -> [UIBarButtonItem] {
        let buttons = [
            UIBarButtonItem(title: "Add String", style: .plain, target: self, action: #selector(didTapOnAddStringButton))
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

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stringsCount = viewModel.numberOfStrings()
        if stringsCount == 0 {
            self.tableView.setEmptyMessage("No strings saved")
        } else {
            self.tableView.restore()
        }
        return stringsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StringTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? StringTableViewCell else {
            assertionFailure("Cannot dequeue StringTableViewCell")
            return UITableViewCell()
        }
        cell.setup(with: viewModel.getString(forIndex: indexPath.row))
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
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (_, _, _) in
            self.viewModel.toStringForm(index: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = Colors.primaryColor

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
            self.showAlert(title: self.localizer.get(LocalizationKeys.genericAlertTitle),
                           message: "Are you sure to delete the string?",
                           confirmAction: { _ in
                self.viewModel.deleteString(forIndex: indexPath.row)
                self.tableView.setEditing(false, animated: true)
            })
        }

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    // MARK: IBAction

    @IBAction private func didTapOnAddStringButton(_ sender: AnyObject) {
        self.viewModel.toEmptyStringForm()
    }
}

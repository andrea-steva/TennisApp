//
//  StringsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

final class StringsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, StoryboardInstantiable {

    static let StringsCellReuseId = "string_cell"

    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: ViewModel

    var viewModel: StringsViewModel!

    // MARK: View Management

    override func localizedTitleString() -> String {
        LocalizationKeys.menuStrings
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchStrings()
    }

    func setupObservers() {
        _ = viewModel.reloadView.observeNext(with: { [weak self] _ in
            self?.tableView.reloadData()
        })
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
        let cell = tableView.dequeueReusableCell(withIdentifier: StringsViewController.StringsCellReuseId, for: indexPath) as! StringTableViewCell
        cell.setString(viewModel.string(forIndex: indexPath.row))
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
            footerView.backgroundColor = Style.Colors.grayColor
        }
        return footerView
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (_, _, _) in
            self.viewModel.toStringForm(index: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = Style.Colors.primaryColor

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
            AlertView.showConfirm(self.localizer.get(LocalizationKeys.genericAlertTitle),
                                  message: "Are you sure to delete the string?",
                                  completionBlock: { (userCancelAction) in
                if !userCancelAction {
                    self.viewModel.deleteString(forIndex: indexPath.row)
                    self.tableView.setEditing(false, animated: true)
                }
            })
        }

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    // MARK: IBAction

    @IBAction private func didTapOnAddStringButton(_ sender: AnyObject) {
        self.viewModel.toEmptyStringForm()
    }
}

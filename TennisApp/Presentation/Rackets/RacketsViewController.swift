//
//  RacketsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class RacketsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, StoryboardInstantiable {

    static let RacketCellReuseId = "racket_cell"

    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    // MARK: ViewModel

    var viewModel: RacketsViewModel!

    // MARK: View Management

    override func localizedTitleString() -> String {
        LocalizationKeys.menuRackets
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObservers()
        self.addPullToRefresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchRackets()
    }

    private func setupObservers() {
        _ = viewModel.reloadView.observeNext(with: { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        })
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
        let cell = tableView.dequeueReusableCell(withIdentifier: RacketsViewController.RacketCellReuseId, for: indexPath) as! RacketTableViewCell
        cell.setRacket(viewModel.racket(forIndex: indexPath.row))
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
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            self.viewModel.toRacketForm(index: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = Style.Colors.primaryColor

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, _) in
            AlertView.showConfirm(self.localizer.get(LocalizationKeys.genericAlertTitle),
                                  message: "Are you sure to delete the racket?",
                                  completionBlock: { (userCancelAction) in
                if !userCancelAction {
                    self.viewModel.deleteRacket(forIndex: indexPath.row)
                    self.tableView.setEditing(false, animated: true)
                }
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

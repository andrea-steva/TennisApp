//
//  StringsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit


final class StringsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let StringsCellReuseId = "string_cell"
    
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    
    // MARK: ViewModel
    
    var viewModel: StringsViewModel!
    
    // MARK: View Management
    
    override func hasMenuButton() -> Bool {
        return false
    }
    
    override func localizedTitleString() -> String {
        return LocalizedString.menu_strings
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
        _ = viewModel.reloadView.observeNext(with: { [weak self] (value) in
            self?.tableView.reloadData()
        })
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfStrings()
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
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        if section == 0 {
            footerView.backgroundColor = Style.Colors.grayColor
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [unowned self] (rowAction, indexPath) in
            
            self.viewModel.toStringForm(index: indexPath.row)
            self.tableView.setEditing(false, animated: true)
        }
        editAction.backgroundColor = UIColor.orange
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { [unowned self] (rowAction, indexPath) in
            
            AlertView.showConfirm(localizer.get(LocalizedString.generic_alertTitle), message: "Are you sure to delete the string?", completionBlock: { (userCancelAction) in
                if !userCancelAction {
                    self.viewModel.deleteString(forIndex: indexPath.row)
                    self.tableView.setEditing(false, animated: true)
                }
            })
            
        }
        return [editAction, deleteAction]
    }
    
    // MARK: IBAction
    
    @IBAction func didTapOnAddStringButton(_ sender: AnyObject) {
        self.viewModel.toEmptyStringForm()
    }
}

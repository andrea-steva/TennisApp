//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView!

    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_profile
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)!.first as! ProfileHeaderView
        self.tableView.addSubview(headerView)
    }
}

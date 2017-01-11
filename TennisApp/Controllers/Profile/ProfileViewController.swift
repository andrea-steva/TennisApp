//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import Tamamushi

class ProfileViewController: BaseViewController, UITableViewDataSource, UITabBarDelegate {

    static let ProfileCellReuseId = "profile_cell"
    
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView!

    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_profile
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: self.navigationController!.navigationBar, direction: .vertical, startColor: Style.Colors.courtHardG, endColor: Style.Colors.courtHardG.lighter())

        let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)!.first as! ProfileHeaderView
        self.tableView.addSubview(headerView)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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

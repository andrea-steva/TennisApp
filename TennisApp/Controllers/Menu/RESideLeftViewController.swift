//
//  RESideLeftViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

class RESideLeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate {

    // MARK: IBAction

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundView: UIImageView!

    // MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = self.backgroundView.image?.applyMenuEffect()
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let menuItem = MenuItem(rawValue: indexPath.row)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell", for: indexPath)
        cell.textLabel?.font = Style.Fonts.get(.light, size: .large)
        cell.textLabel?.textColor = Style.Colors.lightColor.withAlphaComponent(0.7)
        cell.imageView?.image = menuItem.menuIcon()
        cell.textLabel?.text = menuItem.localizedName()

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.selectedBackgroundView = bgColorView

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let menuItem = MenuItem(rawValue: indexPath.row)!
        if menuItem == .logout {
            tableView.deselectRow(at: indexPath, animated: true)

            AlertView.showConfirm(localizer.get(LocalizedString.generic_alertTitle), message: "Are you sure to want to logout?") {  (userCancelAction) in

                if !userCancelAction {
                    FirebaseProxy.sharedInstance.signOut { (success, error) in
                        if let errorMessage = error {
                            Log.error(errorMessage)
                        }
                        AppDelegate.instance.setRootViewController(Utils.getControllerFromStoryboard("Login"))
                    }
                }
            }
            return
        }
        let contentViewController = Utils.getControllerFromStoryboard(menuItem.storyboardName())
        self.sideMenuViewController.setContentViewController(contentViewController, animated: true)
        self.sideMenuViewController.hideViewController()

    }

    // MARK: UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.size.height - CGFloat(200))/CGFloat(MenuItem.count)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}

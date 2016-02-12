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
    
    //MARK: IBAction
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var backgroundView : UIImageView!
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Blur effect
        self.backgroundView.image = self.backgroundView.image?.applyMenuEffect()
        
    }
    
    //MARK: UITableViewDataSource
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("menu_cell", forIndexPath: indexPath)
        cell.textLabel?.font = Style.Fonts.get(.LIGHT, size: 18.0);
        cell.textLabel?.textColor = Style.Colors.lightColor.colorWithAlphaComponent(0.7)
        cell.textLabel?.text = MenuItem(rawValue: indexPath.row)!.getLocalizedName()
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let menuItem = MenuItem(rawValue: indexPath.row)!
        let contentViewController = Utils.getControllerFromStoryboard(menuItem.getStoryboardName())
        self.sideMenuViewController.setContentViewController(contentViewController, animated: true)
        self.sideMenuViewController.hideMenuViewController()
    }
    
    //MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (tableView.frame.size.height - CGFloat(200))/CGFloat(MenuItem.count)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
}

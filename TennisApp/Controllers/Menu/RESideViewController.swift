//
//  RESideViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol TNSideMenuDelegate: class {
    func sideMenuUserLogout()
}

final class RESideViewController: RESideMenu, RESideMenuDelegate, TNSideMenuDelegate {

    // MARK: ViewModel
    var viewModel: RESideViewModel!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.menuPreferredStatusBarStyle = .lightContent
        self.contentViewShadowColor = Style.Colors.darkColor
        self.contentViewShadowOffset = CGSize(width: 0, height: 0)
        self.contentViewShadowOpacity = 0.6
        self.contentViewShadowRadius = 12
        self.contentViewShadowEnabled = true

        self.contentViewController = Utils.getControllerFromStoryboard("Activities", controllerId: "ContentViewController")
        let leftViewController = Utils.getControllerFromStoryboard("Activities", controllerId: "MenuViewController") as! RESideLeftViewController
        leftViewController.resideDelegate = self
        self.leftMenuViewController = leftViewController
        
        self.backgroundImage = UIImage(named: "Stars")
        self.delegate = self
    }

    // MARK: RESideMenuDelegate

    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
    }

    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
    }

    func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {
    }

    func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {
    }
    
    // MARK: TNSideMenuDelegate
    
    func sideMenuUserLogout() {
        self.viewModel.logout()
    }
}

//
//  RESideViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

protocol TNSideMenuDelegate: AnyObject {
    func sideMenuUserLogout()
    func sideMenuSelect(menuItem: RESideMenuItem)
}

final class RESideViewController: RESideMenu, RESideMenuDelegate, TNSideMenuDelegate, StoryboardInstantiable {
    
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

        self.contentViewController = UINavigationController(rootViewController: ActivitiesContainerViewController.instantiateViewController())

        let leftViewController = RESideLeftViewController.instantiateViewController()
        leftViewController.resideDelegate = self
        self.leftMenuViewController = leftViewController
        
        self.backgroundImage = UIImage(named: "Stars")
        self.delegate = self
    }
        
    // MARK: TNSideMenuDelegate
    
    func sideMenuSelect(menuItem: RESideMenuItem) {
        viewModel.userSelect(menuItem: menuItem)
    }
    
    func sideMenuUserLogout() {
        AlertView.showConfirm(localizer.get(LocalizedString.generic_alertTitle), message: "Are you sure to want to logout?") { [unowned self] (userCancelAction) in
            if !userCancelAction {
                self.viewModel.performLogout(completion: { (success, error) in
                    self.viewModel.userDidlogout()
                })
            } else {
                self.hideViewController()
            }
        }
        
    }
}

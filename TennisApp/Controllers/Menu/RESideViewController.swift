//
//  RESideViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import RESideMenu

class RESideViewController: RESideMenu, RESideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.menuPreferredStatusBarStyle = .lightContent;
        self.contentViewShadowColor = Style.Colors.darkColor
        self.contentViewShadowOffset = CGSize(width: 0, height: 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.contentViewController = Utils.getControllerFromStoryboard("Main", controllerId: "ContentViewController")
        self.leftMenuViewController = Utils.getControllerFromStoryboard("Main", controllerId: "MenuViewController")
        self.backgroundImage = UIImage(named: "Stars")
        self.delegate = self;
    }
    
    // MARK: RESideMenu Delegate
    
    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        //DDLogDebug(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
        //DDLogDebug(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {
        //DDLogDebug(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {
        //DDLogDebug(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
    }
    
}

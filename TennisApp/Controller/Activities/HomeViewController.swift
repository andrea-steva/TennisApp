//
//  HomeViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import PagingMenuController

class HomeViewController: BaseViewController, PagingMenuControllerDelegate {
    
    //MARK: Property
    
    var viewModel = BaseViewModel()
    
    /// The array with the view controllers for the paging menu
    private var menuControllers : [ActivitiesViewController] = []
    
    //MARK: View Management
    
    override func controllerTitleKey() -> LocalizerKey {
        return .menu_home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for index in 0...2 {
            let activityController =  Utils.getControllerFromStoryboard("Home", controllerId: "ActivitiesViewController") as! ActivitiesViewController
            //activityController.viewModel.products = Array(activityController.items)
            activityController.title = "Activity \(index+1)"
            menuControllers.append(activityController)
        }

        setupPagedMenu(menuControllers)
    }
    
    private func setupPagedMenu(controllers : [UIViewController]) {
        let options = PagingMenuOptions()
        options.menuHeight = 50
        options.font = Style.Fonts.get(.Regular, size: .Normal)
        options.textColor = Style.Colors.lightColor
        options.selectedFont = Style.Fonts.get(.Regular, size: .Normal)
        options.selectedTextColor = Style.Colors.lightColor
        options.backgroundColor = Style.Colors.courtClay
        options.menuItemMode = PagingMenuOptions.MenuItemMode.RoundRect(radius: 10, horizontalPadding: 10, verticalPadding: 10, selectedColor: Style.Colors.courtClay.darker())
        options.menuDisplayMode = PagingMenuOptions.MenuDisplayMode.SegmentedControl
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        //pagingMenuController.view.backgroundColor = UIColor.clearColor()
        pagingMenuController.setup(viewControllers: controllers, options: options)
    }
    
    // MARK: PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

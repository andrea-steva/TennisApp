//
//  HomeViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import PagingMenuController

// MARK: PagingMenuOptions
private struct PagingMenuOptions: PagingMenuControllerCustomizable {

    init(controllers: [ActivitiesViewController]) {
        self.pagingControllers = controllers
    }

    private var pagingControllers: [ActivitiesViewController]

    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(pagingControllers: self.pagingControllers), pagingControllers: pagingControllers)
    }

    private struct MenuOptions: MenuViewCustomizable {

        init(pagingControllers: [ActivitiesViewController]) {

            self.itemsOptions = []
            for controller in pagingControllers {
                let menuItemViewOptions = MenuItemViewOptions(title: controller.title!)
                self.itemsOptions.append(menuItemViewOptions)
            }
        }

        // MARK: Menu items options
        var itemsOptions: [MenuItemViewCustomizable]

        struct MenuItemViewOptions: MenuItemViewCustomizable {
            private let title: String

            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: self.title,
                                         color: Style.Colors.lightColor,
                                         selectedColor: Style.Colors.lightColor,
                                         font: Style.Fonts.get(.Regular, size: .normal),
                                         selectedFont: Style.Fonts.get(.Regular, size: .normal))

                return .text(title: title)
            }

            init(title: String) {
                self.title = title
            }
        }

        // MARK: Custom menu options

        var backgroundColor: UIColor {
            return Style.Colors.grayColor
        }
        var selectedBackgroundColor: UIColor {
            return Style.Colors.darkColor
        }

        var mode: MenuDisplayMode {
            return .segmentedControl
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 10, horizontalPadding: 10, verticalPadding: 10, selectedColor: Style.Colors.primaryColor)
        }
    }
}

class HomeViewController: BaseViewController {

    // MARK: Property

    /// The array with the view controllers for the paging menu
    fileprivate var menuControllers: [ActivitiesViewController] = []

    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_home
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0...2 {
            let activityController =  Utils.getControllerFromStoryboard("Main", controllerId: "ActivitiesViewController") as! ActivitiesViewController
            activityController.title = "Activity \(index+1)"
            menuControllers.append(activityController)
        }

        setupPagedMenu(menuControllers)
    }

    fileprivate func setupPagedMenu(_ controllers: [UIViewController]) {

        let pagingMenuController = self.childViewControllers.first as! PagingMenuController

        let paginMenuOptions = PagingMenuOptions(controllers: menuControllers)
        pagingMenuController.setup(paginMenuOptions)

        pagingMenuController.onMove = { _ in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

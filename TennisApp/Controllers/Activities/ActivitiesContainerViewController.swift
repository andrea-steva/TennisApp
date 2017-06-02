//
//  ActivitiesContainerViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import PagingMenuController
import Tamamushi

// MARK: MenuItemViewOptions
private struct MenuItemViewOptions: MenuItemViewCustomizable {
    private let title: String
    
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: self.title,
                                 color: Style.Colors.lightColor,
                                 selectedColor: Style.Colors.lightColor,
                                 font: Style.Fonts.get(.regular, size: .normal),
                                 selectedFont: Style.Fonts.get(.regular, size: .normal))
        
        return .text(title: title)
    }
    
    init(title: String) {
        self.title = title
    }
}

// MARK: PagingMenuOptions
private struct PagingMenuOptions: PagingMenuControllerCustomizable {

    init(controllers: [ActivityViewController]) {
        self.pagingControllers = controllers
    }

    private var pagingControllers: [ActivityViewController]

    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(pagingControllers: self.pagingControllers), pagingControllers: pagingControllers)
    }

    private struct MenuOptions: MenuViewCustomizable {

        init(pagingControllers: [ActivityViewController]) {

            self.itemsOptions = []
            for controller in pagingControllers {
                let menuItemViewOptions = MenuItemViewOptions(title: controller.title!)
                self.itemsOptions.append(menuItemViewOptions)
            }
        }

        // MARK: Menu items options
        var itemsOptions: [MenuItemViewCustomizable]

        // MARK: Custom menu options

        var backgroundColor: UIColor {
            return Style.Colors.grayColor
        }
        var selectedBackgroundColor: UIColor {
            return Style.Colors.darkColor
        }

        var displayMode: MenuDisplayMode {
            return .segmentedControl
            //return .infinite(widthMode: .flexible, scrollingMode: .scrollEnabledAndBouces)
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 10, horizontalPadding: 10, verticalPadding: 10, selectedColor: Style.Colors.primaryColor)
        }
    }
}

class ActivitiesContainerViewController: BaseViewController {

    // MARK: Property

    /// The array with the view controllers for the paging menu
    fileprivate var menuControllers: [ActivityViewController] = []

    // MARK: View Management

    override func localizedTitleString() -> String {
        return LocalizedString.menu_home
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        TMGradientNavigationBar().setGradientColorOnNavigationBar(bar: self.navigationController!.navigationBar, direction: .vertical,
                                                                  startColor: Style.Colors.courtClay,
                                                                  endColor: Style.Colors.courtClay.lighter())

        setupPagedMenu(menuControllers)
    }

    fileprivate func setupPagedMenu(_ controllers: [UIViewController]) {

        for index in 0...2 {
            let activityController: ActivityViewController = ActivityViewController.instantiateFromStoryboard("Activities")

            if index == 0 {
                activityController.title = "Matchs"
            }
            if index == 1 {
                activityController.title = "Practice"
            }
            if index == 2 {
                activityController.title = "Fitness"
            }
            menuControllers.append(activityController)
        }

        let pagingMenuController = self.childViewControllers.first as! PagingMenuController

        let pagingMenuOptions = PagingMenuOptions(controllers: menuControllers)
        pagingMenuController.setup(pagingMenuOptions)

        pagingMenuController.onMove = { _ in

        }
    }
}

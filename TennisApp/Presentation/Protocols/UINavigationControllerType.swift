//
//  UINavigationControllerType.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 09/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol UINavigationControllerType: class {
    var viewControllers: [UIViewController] { get }

    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
}

extension UINavigationController: UINavigationControllerType {}

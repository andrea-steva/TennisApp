//
//  TabBarItemCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 05/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol TabBarItemCoordinator: AnyObject {
    @discardableResult
    func start() -> UIViewController
}

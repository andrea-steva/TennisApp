//
//  UIViewController+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/10/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import SwiftUI
import UIKit

extension UIViewController {

    // MARK: Setup hosting controller

    func setupSwiftUI<T: View>(rootView: T) {
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

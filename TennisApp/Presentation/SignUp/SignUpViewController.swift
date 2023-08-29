//
//  SignUpViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

final class SignUpViewController: UIViewController, StoryboardInstantiable {

    // MARK: ViewModel

    var viewModel: SignUpViewModel

    // MARK: Init

    init?(coder: NSCoder, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Missing view model.")
    }

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    // MARK: Setup hosting controller

    private func setupView() {
        let hostingController = UIHostingController(rootView: SignUpView(viewModel: viewModel))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
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

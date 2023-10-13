//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import SwiftUI
import UIKit

final class SettingsViewController: UIViewController, StoryboardInstantiable, BackgroundBlurrable, Alertable {

    // MARK: IBActions

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: ViewModel

    var viewModel: SettingsViewModel

    // MARK: Init

    init?(coder: NSCoder, viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Missing view model.")
    }

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.settingsBackground)
        self.title = Localization.TabBar.settings

        self.setBackgroundBlurEffect()
        self.setupSwiftUI(rootView: SettingsView(viewModel: viewModel))
    }
}

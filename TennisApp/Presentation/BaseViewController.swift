//
//  BaseViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

class BaseViewController: UIViewController, LoadingIndicator {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView?

    // MARK: Properties

    var subscriptions = Set<AnyCancellable>()

    var loadingIndicator: UIActivityIndicatorView?
    let localizer = Localizer()

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        if let backgroundView = self.backgroundView {
            backgroundView.image = backgroundView.image?.applyMenuEffect()
        }

        self.title = localizer.get(localizedTitleString())

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    // MARK: Controller title

    func localizedTitleString() -> String {
        LocalizationKeys.appName
    }

    // MARK: Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }

    deinit {
        Log.debug("Deinit \(self)")
    }
}

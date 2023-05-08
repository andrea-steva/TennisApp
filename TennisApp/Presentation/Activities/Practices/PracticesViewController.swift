//
//  PracticesViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class PracticesViewController: UIViewController, StoryboardInstantiable {

    // MARK: ViewModel

    var viewModel: PracticesViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchPractices()
    }
}

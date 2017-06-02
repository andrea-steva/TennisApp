//
//  StringsCoordinator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 22/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StringsCoordinatorDelegate: class {
    func stringsCoordinatorDidFinish(racketsCoordinator: StringsCoordinator)
}

class StringsCoordinator: Coordinator, StringsViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    weak var delegate: StringsCoordinatorDelegate?
    fileprivate weak var navigationController: UINavigationControllerType?
    
    var stringsViewController: StringsViewController?
    
    // MARK: Coordinator
    
    init(navigationController: UINavigationControllerType) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Strings", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "StringsView") as? StringsViewController else {
            return
        }
        stringsViewController = vc
        let viewModel = StringsViewModel()
        viewModel.coordinatorDelegate = self
        stringsViewController!.viewModel = viewModel
        navigationController?.pushViewController(stringsViewController!, animated: true)
    }
    
    // MARK: StringsViewModelCoordinatorDelegate
    
    func stringViewModelDidEnd(_ viewModel: StringsViewModel) {
        delegate?.stringsCoordinatorDidFinish(racketsCoordinator: self)
    }
    
    deinit {
        Log.verbose("+++ Deinit \(self) +++")
    }
}

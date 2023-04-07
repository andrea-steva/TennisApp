//
//  MatchesViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class MatchesViewController: UIViewController, StoryboardInstantiable {

    static let ActivityCellReuseId = "activity_cell"

    // MARK: IBOutlet

    @IBOutlet private var tableView: UITableView!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

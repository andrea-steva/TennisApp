//
//  ActivityViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class ActivityViewController: UIViewController {

    static let ActivityCellReuseId = "activity_cell"

    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!

    // MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

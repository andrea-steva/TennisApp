//
//  RacketsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class RacketsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let RacketCellReuseId = "racket_cell"
    
    // MARK: IBOutlets
    
    @IBOutlet var tableView : UITableView!
    
    // MARK: ViewModel
    var viewModel = RacketsViewModel()
    
    // MARK: View Management
    
    override func controllerTitleKey() -> LocalizerKey {
        return .menu_rackets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRacketsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RacketsViewController.RacketCellReuseId, for: indexPath) as! RacketTableViewCell

        let racket = viewModel.getRacket(forIndex: indexPath.row)
        cell.setRacket(racket)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        if section == 0 {
            footerView.backgroundColor = Style.Colors.grayColor
        }
        return footerView
    }
    
}

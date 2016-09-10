//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    //MARK: IBOutlets
    @IBOutlet var tableView : UITableView!
    
    //MARK: View Management
    
    override func controllerTitleKey() -> LocalizerKey {
        return .menu_profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let headerView = NSBundle.mainBundle().loadNibNamed("ProfileHeaderView", owner: self, options: nil)!.first as! ProfileHeaderView
        self.tableView.addSubview(headerView)
        
        //self.stretchyHeaderView = nibViews.firstObject;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

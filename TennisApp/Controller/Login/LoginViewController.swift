//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    //MARK: IBOutlets
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var firstNameTextField : UITextField!
    @IBOutlet var lastNameTextField : UITextField!
    @IBOutlet var startButton : UIButton!
    
    //MARK: ViewModel
    var viewModel = LoginViewModel()
    
    //MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    //MARK: IBAction
    
    @IBAction func didTapStartButton(sender : UIButton) {
        AppDelegate.instance().setRootViewController(Utils.getControllerFromStoryboard("Main"))
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

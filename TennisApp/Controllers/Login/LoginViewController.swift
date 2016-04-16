//
//  LoginViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import ALCameraViewController

class LoginViewController: BaseViewController {
    
    //MARK: IBOutlets
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var firstNameTextField : UITextField!
    @IBOutlet var lastNameTextField : UITextField!
    @IBOutlet var startButton : UIButton!
    @IBOutlet var cameraButton : UIButton!
    
    //MARK: ViewModel
    var viewModel = LoginViewModel()
    
    //MARK: View Management
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImageView.layer.cornerRadius = 20.0
        self.userImageView.layer.borderColor = Style.Colors.lightColor.CGColor
        self.userImageView.layer.borderWidth = 5.0
        
        self.backgroundView?.image = self.backgroundView?.image?.applyMenuEffect()
    }
    
    //MARK: IBAction
    
    @IBAction func didTapStartButton(sender : UIButton) {
        AppDelegate.instance().setRootViewController(Utils.getControllerFromStoryboard("Main"))
    }
    
    @IBAction func didTapOnCameraButton(sender: AnyObject) {
        
        let cameraViewController = CameraViewController(croppingEnabled: true) { (image, asset) in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            self.userImageView.image = image
        }
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
}

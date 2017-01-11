//
//  ProfileHeaderView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
import Firebase

class ProfileHeaderView: GSKStretchyHeaderView {
    
    // MARK: IBOutlets
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 20.0
            userImageView.layer.borderColor = Style.Colors.lightColor.cgColor
            userImageView.layer.borderWidth = 5.0        }
    }
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var navigationTitleLabel: UILabel!
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.minimumContentHeight = 64.0
        
        if let profileImageURL = FirebaseProxy.sharedInstance.currentUser?.photoURL {
            self.userImageView.af_setImage(withURL: profileImageURL)
        }
        if let displayName = FirebaseProxy.sharedInstance.currentUser?.displayName {
            self.userNameLabel.text = displayName
            self.navigationTitleLabel.text = displayName
        }
    }
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        
        var alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1)
        alpha = max(0, min(1, alpha))
        
        self.userImageView.alpha = alpha
        self.userNameLabel.alpha = alpha
        
        self.backgroundImageView.alpha = alpha
        
        let navTitleFactor: CGFloat = 0.4
        var navTitleAlpha: CGFloat = 0
        if (stretchFactor < navTitleFactor) {
            navTitleAlpha = CGFloatTranslateRange(stretchFactor, 0, navTitleFactor, 2, 0)
        }
        self.navigationTitleLabel.alpha = navTitleAlpha
    }
}

//
//  ProfileHeaderView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class ProfileHeaderView: GSKStretchyHeaderView {
    
    
    //MARK: IBOutlets
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var userNameLabel : UILabel!
    @IBOutlet var navigationTitleLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.cornerRadius = 20.0
        self.userImageView.layer.borderColor = Style.Colors.lightColor.cgColor
        self.userImageView.layer.borderWidth = 5.0
    
        self.minimumContentHeight = 64.0
    }
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        
        var alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1)
        alpha = max(0, min(1, alpha))
        
        self.userImageView.alpha = alpha
        self.userNameLabel.alpha = alpha
        
        self.backgroundImageView.alpha = alpha
        
        let navTitleFactor : CGFloat = 0.4
        var navTitleAlpha : CGFloat = 0
        if (stretchFactor < navTitleFactor) {
            navTitleAlpha = CGFloatTranslateRange(stretchFactor, 0, navTitleFactor, 2, 0)
        }
        self.navigationTitleLabel.alpha = navTitleAlpha;
    }
}

//
//  ProfileHeaderView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import GSKStretchyHeaderView
import UIKit

final class ProfileHeaderView: GSKStretchyHeaderView {

    // MARK: IBOutlets

    @IBOutlet private var backgroundImageView: UIImageView!

    @IBOutlet private var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 20.0
            userImageView.layer.borderColor = Style.Colors.lightColor.cgColor
            userImageView.layer.borderWidth = 5.0        }
    }

    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var navigationTitleLabel: UILabel!

    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        self.minimumContentHeight = 64.0

//        if let profileImageURL = FirebaseService.shared.userPhotoURL {
//            self.userImageView.af_setImage(withURL: profileImageURL)
//        }
        if let displayName = FirebaseService.shared.currentUser?.displayName {
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
        if stretchFactor < navTitleFactor {
            navTitleAlpha = CGFloatTranslateRange(stretchFactor, 0, navTitleFactor, 2, 0)
        }
        self.navigationTitleLabel.alpha = navTitleAlpha
    }
}

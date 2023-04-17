//
//  ProfileHeaderView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView {

    // MARK: IBOutlets

    @IBOutlet private var backgroundImageView: UIImageView!

    @IBOutlet private var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 20.0
            userImageView.layer.borderColor = Colors.lightColor.cgColor
            userImageView.layer.borderWidth = 5.0
        }
    }

    @IBOutlet private var userNameLabel: UILabel!

    private let viewModel = ProfileHeaderViewModel()

    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        if let displayName = self.viewModel.displayName {
            self.userNameLabel.text = displayName
        }
    }
}

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

    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: Setup cell

    func setup(with viewModel: ProfileHeaderViewModelType) {
        userNameLabel.text = "\(viewModel.firstName) \(viewModel.lastName)"
    }
}

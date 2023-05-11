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
            userImageView.layer.borderColor = designLibrary.color.text.light.cgColor
            userImageView.layer.borderWidth = 5.0
        }
    }

    @IBOutlet private var userNameLabel: UILabel!

    // MARK: Properties

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundImageView.image = UIImage(named: designLibrary.miscellaneous.asset.racketsBackground)
    }

    // MARK: Setup cell

    func setup(with viewModel: ProfileHeaderViewModelType) {
        userNameLabel.text = "\(viewModel.firstName) \(viewModel.lastName)"
    }
}

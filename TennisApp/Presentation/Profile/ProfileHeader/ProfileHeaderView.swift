//
//  ProfileHeaderView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/03/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView, UIContentView {

    // MARK: IBOutlets

    @IBOutlet private var containerView: UIView!
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

    private var currentConfiguration: ProfileHeaderViewModel!

    var configuration: UIContentConfiguration {
        get { currentConfiguration }
        set {
            guard let newConfig = newValue as? ProfileHeaderViewModel else { return }
            apply(configuration: newConfig)
        }
    }

    // MARK: Methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(configuration: ProfileHeaderViewModel) {
        super.init(frame: .zero)

        loadNib()
        setupAppearance()
        apply(configuration: configuration)
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("\(ProfileHeaderView.self)", owner: self, options: nil)

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0)
        ])
    }

    private func setupAppearance() {
        userNameLabel.font = designLibrary.font.textNormalSize.regular
        userNameLabel.textColor = designLibrary.color.text.light
        backgroundImageView.image = UIImage(named: designLibrary.miscellaneous.asset.profileBackground)
    }

    private func apply(configuration: ProfileHeaderViewModel) {

        // Only apply configuration if new configuration and current configuration are not the same
        guard currentConfiguration != configuration else {
            return
        }

        // Replace current configuration with new configuration
        currentConfiguration = configuration

        userNameLabel.text = "\(configuration.firstName) \(configuration.lastName)"
    }
}

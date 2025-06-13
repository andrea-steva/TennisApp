//
//  RacketContentView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class RacketContentView: UIView, UIContentView {

    // MARK: IBOutlets

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var racketTitleLabel: UILabel!
    @IBOutlet private var racketInfoLabel: UILabel!
    @IBOutlet private var stringsCounterLabel: UILabel!

    // MARK: Properties

    private var designLibrary: DesignLibraryProvider = DesignLibrary()

    private var currentConfiguration: RacketViewModel!

    var configuration: UIContentConfiguration {
        get { currentConfiguration }
        set {
            guard let newConfig = newValue as? RacketViewModel else { return }
            apply(configuration: newConfig)
        }
    }

    // MARK: Methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(configuration: RacketViewModel) {
        super.init(frame: .zero)

        loadNib()
        setupAppearance()
        apply(configuration: configuration)
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("\(RacketContentView.self)", owner: self, options: nil)

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
        racketTitleLabel.font = designLibrary.font.textNormalSize.regular
        racketTitleLabel.textColor = designLibrary.color.text.light

        racketInfoLabel.font = designLibrary.font.textNormalSize.regular
        racketInfoLabel.textColor = designLibrary.color.text.light

        stringsCounterLabel.font = designLibrary.font.textNormalSize.light
        stringsCounterLabel.textColor = designLibrary.color.text.light
        stringsCounterLabel.text = ""
    }

    private func apply(configuration: RacketViewModel) {

        // Only apply configuration if new configuration and current configuration are not the same
        guard currentConfiguration != configuration else {
            return
        }

        // Replace current configuration with new configuration
        currentConfiguration = configuration

        racketTitleLabel.text = "\(configuration.manufacter) \(configuration.model)"

        if configuration.sport == .tennis {
            stringsCounterLabel.text = "Strings: \(configuration.strings.count)"
        }

        let description = "\(configuration.sport.rawValue) - Grip: \(configuration.gripSize) - Weight: \(configuration.weight)" +
        "\nPurchased date: \(configuration.purchaseDate?.formattedyyyyMMddHHmmss ?? "")"
        racketInfoLabel.text = description

        if let image = configuration.image?.aspectFittedToHeight(250) {
            backgroundImageView.image = image
        }
    }
}

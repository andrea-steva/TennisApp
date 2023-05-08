//
//  StringContentView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

final class StringContentView: UIView, UIContentView {

    // MARK: IBOutlets

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var stringNameLabel: UILabel!

    // MARK: View Management

    private var currentConfiguration: StringViewModel!

    var configuration: UIContentConfiguration {
        get { currentConfiguration }
        set {
            guard let newConfig = newValue as? StringViewModel else { return }
            apply(configuration: newConfig)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(configuration: StringViewModel) {
        super.init(frame: .zero)

        loadNib()
        setupAppearance()
        apply(configuration: configuration)
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("\(StringContentView.self)", owner: self, options: nil)

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
        stringNameLabel.font = Fonts.get(.regular, size: .normal)
        stringNameLabel.textColor = Colors.lightColor
    }

    private func apply(configuration: StringViewModel) {

        // Only apply configuration if new configuration and current configuration are not the same
        guard currentConfiguration != configuration else {
            return
        }

        // Replace current configuration with new configuration
        currentConfiguration = configuration

        stringNameLabel.text = "\(configuration.manufacter) - \(configuration.model)"
        + " - \(configuration.tension) - \(configuration.gauge) - \(configuration.duration)"
    }
}

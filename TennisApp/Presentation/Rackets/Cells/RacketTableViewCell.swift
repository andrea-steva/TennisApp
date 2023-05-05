//
//  RacketTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class RacketTableViewCell: UITableViewCell {

    // MARK: Reuse Identifier

    static let reuseIdentifier = String(describing: RacketTableViewCell.self)

    // MARK: IBOutlets

    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var racketTitleLabel: UILabel!
    @IBOutlet private var racketInfoLabel: UILabel!
    @IBOutlet private var stringsCounterLabel: UILabel!

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        racketTitleLabel.font = Fonts.get(.regular, size: .extraLarge)
        racketTitleLabel.textColor = Colors.lightColor

        racketInfoLabel.font = Fonts.get(.regular, size: .normal)
        racketInfoLabel.textColor = Colors.lightColor

        stringsCounterLabel.font = Fonts.get(.light, size: .normal)
        stringsCounterLabel.textColor = Colors.lightColor
        stringsCounterLabel.text = ""

        backgroundImageView.image = nil
        contentView.backgroundColor = Colors.courtHardPurple
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 10
    }

    // MARK: Setup cell

    func setup(with viewModel: RacketCellViewModelType) {
        racketTitleLabel.text = "\(viewModel.manufacter) \(viewModel.model)"

        if viewModel.sport == .tennis {
            stringsCounterLabel.text = "Strings: \(viewModel.strings.count)"
        }

        let description = "\(viewModel.sport.rawValue) - Grip: \(viewModel.gripSize) - Weight: \(viewModel.weight)" +
        "\nPurchased date: \(viewModel.purchaseDate?.formattedyyyyMMddHHmmss ?? "")"
        racketInfoLabel.text = description

        if let image = viewModel.image?.aspectFittedToHeight(250) {
            backgroundImageView.image = image
        }
    }
}

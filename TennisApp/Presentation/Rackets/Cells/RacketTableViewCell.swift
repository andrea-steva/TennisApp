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

    @IBOutlet private var racketNameLabel: UILabel!

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        racketNameLabel.font = Style.Fonts.get(.regular, size: .normal)
        racketNameLabel.textColor = Style.Colors.lightColor
    }

    // MARK: Setup cell

    func setup(with viewModel: RacketCellViewModelType) {
        racketNameLabel.text = "\(viewModel.manufacter) - \(viewModel.model)"
    }
}

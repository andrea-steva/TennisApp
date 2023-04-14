//
//  StringTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

final class StringTableViewCell: UITableViewCell {

    // MARK: Reuse Identifier

    static let reuseIdentifier = String(describing: StringTableViewCell.self)

    // MARK: IBAction

    @IBOutlet private var stringNameLabel: UILabel!

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        stringNameLabel.font = Fonts.get(.regular, size: .normal)
        stringNameLabel.textColor = Colors.lightColor
    }

    // MARK: Setup cell

    func setup(with viewModel: StringCellViewModelType) {
        stringNameLabel.text = "\(viewModel.manufacter) - \(viewModel.model)"
    }
}

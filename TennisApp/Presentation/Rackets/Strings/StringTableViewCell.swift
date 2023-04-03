//
//  StringTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

class StringTableViewCell: UITableViewCell {

    // MARK: IBAction

    @IBOutlet var stringNameLabel: UILabel!

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        stringNameLabel.font = Style.Fonts.get(.regular, size: .normal)
        stringNameLabel.textColor = Style.Colors.lightColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setString(_ string: StringsEntity) {

        if let manufacter = string.manufacter, let model = string.model {
            stringNameLabel.text = "\(manufacter) - \(model)"
        }

    }

}

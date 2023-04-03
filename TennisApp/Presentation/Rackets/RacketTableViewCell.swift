//
//  RacketTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class RacketTableViewCell: UITableViewCell {

    // MARK: IBAction

    @IBOutlet var racketNameLabel: UILabel!

    // MARK: View Management

    override func awakeFromNib() {
        super.awakeFromNib()

        racketNameLabel.font = Style.Fonts.get(.regular, size: .normal)
        racketNameLabel.textColor = Style.Colors.lightColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setRacket(_ racket: RacketEntity) {

        if let manufacter = racket.manufacter, let model = racket.model {
            racketNameLabel.text = "\(manufacter) - \(model)"
        }

    }

}

//
//  RacketTableViewCell.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

class RacketTableViewCell: UITableViewCell {

    // MARK: IBAction
    
    @IBOutlet var racketNameLabel : UILabel!
    
    // MARK: View Management
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        racketNameLabel.font = Style.Fonts.get(.Regular, size: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRacket(_ racket : Racket) {
        
    }

}

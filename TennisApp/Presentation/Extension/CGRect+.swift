//
//  CGRect+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

extension CGRect {

    /// The CGRect center
    var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }
}

//
//  CGSize+.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

extension CGSize {

    /// Change an existing CGSize by a width delta and a height delta
    /// - Parameters:
    ///   - deltaWidth: width delta
    ///   - deltaHeight: height delta
    /// - Returns: The new CGSize
    func sizeByDelta(deltaWidth: CGFloat, deltaHeight: CGFloat) -> CGSize {
        CGSize(width: self.width + deltaWidth, height: self.height + deltaHeight)
    }
}

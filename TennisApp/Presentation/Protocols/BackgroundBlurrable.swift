//
//  BackgroundBlurrable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol BackgroundBlurrable {
    var backgroundView: UIImageView! { get }

    func setBackgroundBlurEffect()
}

extension BackgroundBlurrable where Self: UIViewController {
    func setBackgroundBlurEffect() {
        backgroundView.image = backgroundView.image?.applyMenuEffect()
    }
}

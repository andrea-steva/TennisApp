//
//  LoadingIndicator.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 05/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol LoadingIndicator: AnyObject {
    var loadingIndicator: UIActivityIndicatorView? { get set }
}

extension LoadingIndicator where Self: UIViewController {

    func showHUD() {
        DispatchQueue.main.async {
            if self.loadingIndicator == nil, let window = UIApplication.shared.windows.first {
                let frame = UIScreen.main.bounds
                let loadingIndicator = UIActivityIndicatorView(frame: frame)
                loadingIndicator.style = .large
                loadingIndicator.color = .systemOrange
                window.addSubview(loadingIndicator)

                loadingIndicator.startAnimating()
                self.loadingIndicator = loadingIndicator
            }
        }
    }

    func hideHUD() {
        DispatchQueue.main.async {
            guard let loadingIndicator = self.loadingIndicator else { return }
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
            self.loadingIndicator = nil
        }
    }
}

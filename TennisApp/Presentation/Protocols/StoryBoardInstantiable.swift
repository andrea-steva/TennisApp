//
//  StoryBoardInstantiable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 04/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T

    static var defaultFileName: String { get }

    static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        // swiftlint:disable:next force_unwrapping
        NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return viewController
    }

    static func instantiateViewController(_ bundle: Bundle? = nil, creator: @escaping (_ coder: NSCoder) -> UIViewController? ) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(identifier: fileName, creator: { coder in
            creator(coder)
        }) as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return viewController
    }
}

//
//  Storable.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/07/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import RealmSwift

/// Storable object
public protocol Storable {
}

extension Object: Storable {
}

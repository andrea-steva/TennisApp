//
//  Constants.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 26/12/2016.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //Time Interval
    static let dayTimeInterval: TimeInterval = 60 * 60 * 24
    static let hourTimeInterval: TimeInterval = 60 * 60
    static let minuteTimeInterval: TimeInterval = 60
    
    /// Twitter user account refresh time interval (minutes)
    static let ownerRefreshTimeInterval: TimeInterval = 60 * 5
    
    /// Multiple request time inteval
    static let multipleRequestTimeInterval: TimeInterval = 12.0
    
    //Pagination size
    static let pageSize: Int = 20
    
    //Empty Data set image size
    static let emptyDataSetImageSize = CGSize(width: 150, height: 150)
    
    //Edge inset for image
    static let imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    
    struct NotificationKeys {
        static let signedIn = "signed_in"
    }
}

//
//  main.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)

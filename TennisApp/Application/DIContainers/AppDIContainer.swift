//
//  AppDIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class AppDIContainer {
    private(set) lazy var loginDIContainer = LoginDIContainer()
    private(set) lazy var signUpDIContainer = SignUpDIContainer()
    private(set) lazy var activitiesDIContainer = ActivitiesDIContainer()
    private(set) lazy var racketsDIContainer = RacketsDIContainer()
    private(set) lazy var stringsDIContainer = StringsDIContainer()
    private(set) lazy var statsDIContainer = StatsDIContainer()
    private(set) lazy var profileDIContainer = ProfileDIContainer()
    private(set) lazy var settingsDIContainer = SettingsDIContainer()
}

//
//  StatsContainerView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/10/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import SwiftUI

struct StatsContainerView: View {
    var body: some View {
        ScrollView {
            BarChartView()
        }
    }
}

#Preview {
    StatsContainerView()
        .backgroundStyle(.red)
}

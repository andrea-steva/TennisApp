//
//  BarChartView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/10/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Charts
import SwiftUI

struct ChartData: Identifiable, Equatable {
    let type: String
    let count: Int

    var id: String { type }
}

struct BarChartView: View {

    let data = [
        ChartData(type: "Match", count: 10),
        ChartData(type: "Workout", count: 6),
        ChartData(type: "Practice", count: 18)
    ]

    var body: some View {
        Chart(data) { dataPoint in
            BarMark(x: .value(dataPoint.type, dataPoint.type),
                    y: .value(dataPoint.type, dataPoint.count))
            .foregroundStyle(by: .value("Type", dataPoint.type))
            .annotation(position: .top) {
                Text(String(dataPoint.count))
                    .foregroundStyle(.secondary)
            }
            .cornerRadius(10)
        }
        .chartLegend(.hidden)
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
            }
        }
        .chartYAxis(.hidden)
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .background(in: RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        .backgroundStyle(.white)
        .padding()
    }

}

#Preview {
    BarChartView()
}

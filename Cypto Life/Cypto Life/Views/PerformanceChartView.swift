//
//  PerformanceChartView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI
import Charts

struct PerformanceChartView: View {
    let sparkline: [String?]

    var body: some View {
        let values = sparkline.compactMap { $0 }.compactMap(Double.init)
        if values.isEmpty {
            Text("No data available")
        } else {
            Chart {
                ForEach(values.indices, id: \.self) { index in
                    LineMark(
                        x: .value("Time", index),
                        y: .value("Price", values[index])
                    )
                }
            }
            .frame(height: 200)
            .padding()
        }
    }
}

//
//  CoinDetailsView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI

struct CoinDetailsView: View {
    @ObservedObject var viewModel: CoinDetailsViewModel

    var body: some View {
        VStack {
            if let coin = viewModel.selectedCoin {
                CoinHeaderView(coin: coin)
                PerformanceChartView(sparkline: coin.sparkline)
                FilterView()
                StatsView(coin: coin)
            } else {
                Text("No coin selected")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

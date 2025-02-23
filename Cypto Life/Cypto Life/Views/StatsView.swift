//
//  StatsView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI

struct StatsView: View {
    let coin: CryptoCoin

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Statistics")
                .font(.headline)

            HStack {
                Text("Market Cap:")
                Spacer()
                Text(coin.formattedMarketCap)
            }

            HStack {
                Text("24H Volume:")
                Spacer()
                Text("$\(String(coin.volume24h.prefix(10)))")
            }
            HStack {
                Text("BTC Price:")
                Spacer()
                Text(coin.btcPrice)
            }

            HStack {
                Text("Price Change:")
                Spacer()
                Text(coin.formattedChange)
                    .foregroundColor(coin.change.contains("-") ? .red : .green)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }
}


//
//  CoinHeaderView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI

struct CoinHeaderView: View {
    let coin: CryptoCoin

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.iconUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.title)
                    .bold()
                Text(coin.symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(coin.formattedPrice)
                .font(.title2)
        }
        .padding()
    }
}

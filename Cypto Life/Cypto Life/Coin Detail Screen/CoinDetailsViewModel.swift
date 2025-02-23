//
//  CoinDetailsViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    @Published var selectedCoin: CryptoCoin?

    init(coin: CryptoCoin? = nil) {
        self.selectedCoin = coin
    }
}

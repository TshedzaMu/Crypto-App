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
    
    func removeFromFavorites(coin: CryptoCoin) {
        UserDefaults.savedfavorites.removeAll(where: { $0.uuid == coin.uuid })
    }
    
    func addToFavorites(coin: CryptoCoin) {
        UserDefaults.addToFavorites(coin)
    }
}

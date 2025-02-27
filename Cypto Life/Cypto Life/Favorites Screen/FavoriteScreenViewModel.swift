//
//  FavoriteScreenViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit
import SwiftUI

class FavoriteScreenViewModel {
    var favoritesList: [String] = UserDefaults.savedFavoriteCoin
    var selectedCoin: CryptoCoin?
    
    var favoriteListCount: Int {
        return favoritesList.count
    }
    
    var allCoins: [CryptoCoin] {
        guard let coins = SharedData.shared.allCoins else { return [] }
        return coins
    }
    
    func resetFavorites() {
        favoritesList = UserDefaults.savedFavoriteCoin 
    }
    
    func removeFromFavorites(coinID: String)  {
        UserDefaults.savedFavoriteCoin.removeAll(where: { $0 == coinID })
    }
}

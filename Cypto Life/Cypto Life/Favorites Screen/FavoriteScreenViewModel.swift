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
    var favoritesList: [CryptoCoin] = UserDefaults.savedfavorites 
    
    var favoriteListCount: Int {
        return favoritesList.count
    }
    
    func resetFavorites() {
        favoritesList = UserDefaults.savedfavorites 
    }
    
    func removeFromFavorites(coin: CryptoCoin) {
        UserDefaults.savedfavorites.removeAll(where: { $0.uuid == coin.uuid })
    }
}

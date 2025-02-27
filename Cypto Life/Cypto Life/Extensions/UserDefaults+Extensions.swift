//
//  Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

extension UserDefaults {
    private enum Keys {
        static let favorites = "favorites"
    }
    
    static var savedFavoriteCoin: [String] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.favorites) else { return [] }
            do {
                let coins = try JSONDecoder().decode([String].self, from: data)
                return coins
            } catch {
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.favorites)
            } catch {
                print("Unable to Encode coin data (\(error))")
            }
        }
    }
    
    static func addToFavorites(_ coinID: String) {
        var currentFavorites = UserDefaults.savedFavoriteCoin
        currentFavorites.append(coinID)
        UserDefaults.savedFavoriteCoin = currentFavorites
    }
    
    static func isFavorite(_ coinID: String) -> Bool {
        let favorites = UserDefaults.savedFavoriteCoin
        return favorites.contains(coinID)
    }
}

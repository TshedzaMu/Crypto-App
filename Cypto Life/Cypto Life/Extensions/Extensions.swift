//
//  Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UserDefaults {
    private enum Keys {
        static let favorites = "favorites"
    }
    
    static var savedfavorites: [CryptoCoin] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.favorites) else {return []}
            do {
                let decoder = JSONDecoder()
                let coins = try decoder.decode([CryptoCoin].self, from: data)
                return coins
            } catch {
                return []
            }
        }
        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.favorites)
            } catch {
                print("Unable to Encode coin data (\(error))")
            }        }
    }
    
    static func addToFavorites(_ coin: CryptoCoin) {
        var currentFavorites = UserDefaults.savedfavorites
        currentFavorites.append(coin)
        print("saved")
        UserDefaults.savedfavorites = currentFavorites
    }
    
    static func isFavorite(_ coin: CryptoCoin?) -> Bool {
        let favorites = UserDefaults.savedfavorites
        guard let coin = coin else  { return false }
        return favorites.contains(coin)
    }
}

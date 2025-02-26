//
//  Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

let ACTIVITY_INDICATOR_TAG = 001

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

extension UIViewController {
       
  func startActivityIndicator() {
      let loc =  self.view.center
      let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.tag = ACTIVITY_INDICATOR_TAG
      activityIndicator.center = loc
      activityIndicator.hidesWhenStopped = true
            
      activityIndicator.startAnimating()
      self.view.addSubview(activityIndicator)
   }
        
   func stopActivityIndicator() {
      if let activityIndicator = self.view.subviews.filter(
      { $0.tag == ACTIVITY_INDICATOR_TAG}).first as? UIActivityIndicatorView {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
      }
    }
}

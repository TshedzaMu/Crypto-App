//
//  HomeScreenViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

class HomeScreenViewModel {
    var allCoins: [CryptoCoin] = []
    var displayedCoins: [CryptoCoin] = []
    var selectedCoin: CryptoCoin?
    private let pageSize = 20
    private var currentPage = 0

    lazy var interactor: InteractorProtocol = Interactor(service: Service())
    
    var onCoinsFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    var coinListTotal: Int {
        return displayedCoins.count
    }

    func getCoinList() {
        interactor.getCoins { [weak self] result in
            switch result {
            case .success(let response):
                self?.allCoins = response.data.coins
                self?.displayedCoins = self?.allCoins ?? []
                self?.onCoinsFetched?()
            case .failure(let error):
                self?.onFetchFailed?(error.localizedDescription)
            }
        }
    }

    func loadMoreCoins() {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allCoins.count)

        if startIndex < allCoins.count {
            displayedCoins.append(contentsOf: allCoins[startIndex..<endIndex])
            currentPage += 1
            onCoinsFetched?()
        }
    }

    func toggleFavorite(for coin: CryptoCoin) {
        if UserDefaults.isFavorite(coin) {
            removeFromFavorites(coin: coin)
        } else {
            UserDefaults.addToFavorites(coin)
        }
    }
    
    func removeFromFavorites(coin: CryptoCoin) {
        UserDefaults.savedfavorites.removeAll(where: { $0.uuid == coin.uuid })
    }
    
    
    func sortByPrice() {
        displayedCoins.sort { (Double($0.price) ?? 0) > (Double($1.price) ?? 0) }
        onCoinsFetched?()
    }
    
    func sortByBestPerformance() {
        displayedCoins.sort { (Double($0.change) ?? 0) > (Double($1.change) ?? 0) }
        onCoinsFetched?()
    }
}

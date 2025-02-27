//
//  HomeScreenViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

class SharedData {
    static let shared = SharedData()
    var allCoins: [CryptoCoin]? = []
}

class HomeScreenViewModel {
    var allCoins: [CryptoCoin] = []
    var displayedCoins: [CryptoCoin] = []
    var selectedCoin: CryptoCoin?
    
    private var currentIndex: Int = 0
    private let coinsPerBatch: Int = 20
    
    lazy var interactor: InteractorProtocol = Interactor(service: Service())
    
    var onCoinsFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    func getCoinList() {
        interactor.getCoins { [weak self] result in
            switch result {
            case .success(let response):
                self?.allCoins = response.data.coins
                SharedData.shared.allCoins = response.data.coins
                self?.loadNextBatch()
            case .failure(let error):
                self?.onFetchFailed?(error.localizedDescription)
            }
        }
    }
    
    func loadNextBatch() {
        let endIndex = min(currentIndex + coinsPerBatch, allCoins.count)

        if currentIndex < allCoins.count {
            let newCoins = allCoins[currentIndex..<endIndex]
            displayedCoins.append(contentsOf: newCoins)
            currentIndex = endIndex
            onCoinsFetched?()
        }
    }

    func loadNextBatchIfNeeded(currentIndex: Int) {
        if currentIndex == displayedCoins.count {
            loadNextBatch()
        }
    }
    
    func toggleFavorite(for coinID: String) {
        if UserDefaults.isFavorite(coinID) {
            removeFromFavorites(coinID: coinID)
        } else {
            UserDefaults.addToFavorites(coinID)
        }
    }
    
    func removeFromFavorites(coinID: String) {
        UserDefaults.savedFavoriteCoin.removeAll(where: { $0 == coinID })
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

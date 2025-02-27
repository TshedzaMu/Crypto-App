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
                SharedData.shared.allCoins = self?.allCoins ?? []
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

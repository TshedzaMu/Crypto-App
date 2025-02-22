//
//  HomeScreenViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

class HomeScreenViewModel {
    var allCoins: [CryptoCoin] = []
    var displayedCoins: [CryptoCoin] = [] 
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
                self?.loadMoreCoins()
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
}

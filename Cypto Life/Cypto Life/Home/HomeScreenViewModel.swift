//
//  HomeScreenViewModel.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

class HomeScreenViewModel {

    var coinList: [CryptoCoin]?
    var coinTotal: Int?
 
    lazy var interactor: InteractorProtocol = Interactor(service: Service())
    
    var onCoinsFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    var coinListTotal: Int {
        return coinTotal ?? Int()
    }
    
    func getCoinList() {
        interactor.getCoins { [weak self] result in
            switch result {
            case .success(let response):
                self?.coinList = response.data.coins
                self?.coinTotal = response.data.stats.totalCoins
                self?.onCoinsFetched?()
            case .failure(let error):
                let errorMessage = error.localizedDescription
                print("Failed to fetch coins, error: \(errorMessage)")
                self?.onFetchFailed?(errorMessage)
            }
        }
    }
}

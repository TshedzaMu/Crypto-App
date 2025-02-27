//
//  CoinDeatilsViewModel.swift
//  Cypto LifeTests
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//

import XCTest
@testable import Cypto_Life

class CoinDetailsViewModelTests: XCTestCase {

    var viewModel: CoinDetailsViewModel!

    override func setUp() {
        super.setUp()
        UserDefaults.savedFavoriteCoin = []
        viewModel = CoinDetailsViewModel()
    }
    
    override func tearDown() {
        UserDefaults.savedFavoriteCoin = []
        viewModel = nil
        super.tearDown()
    }

    func testAddToFavorites() {
        viewModel.addToFavorites(coinID: "coin1")

        XCTAssertTrue(UserDefaults.savedFavoriteCoin.contains("coin1"))
    }
    
    func testRemoveFromFavorites() {
        UserDefaults.savedFavoriteCoin = ["coin1", "coin2", "coin3"]
  
        viewModel.removeFromFavorites(coinID: "coin2")
        
        XCTAssertFalse(UserDefaults.savedFavoriteCoin.contains("coin2"))
        XCTAssertEqual(UserDefaults.savedFavoriteCoin, ["coin1", "coin3"])
    }
    
    func testAddToFavoritesExistingCoin() {

        UserDefaults.savedFavoriteCoin = ["coin1", "coin2"]

        viewModel.addToFavorites(coinID: "coin1")
  
        XCTAssertNotEqual(UserDefaults.savedFavoriteCoin, ["coin1", "coin2"])
    }

    func testSelectedCoin() {
        let coin = CryptoCoin(uuid: "123", symbol: "BTC", name: "Bitcoin", color: "yellow", iconUrl: "", marketCap: "", price: "", listedAt: 0, tier: 1, change: "", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "", btcPrice: "", contractAddresses: [])
        
        let viewModelWithCoin = CoinDetailsViewModel(coin: coin)
   
        XCTAssertEqual(viewModelWithCoin.selectedCoin?.uuid, coin.uuid)
    }
}

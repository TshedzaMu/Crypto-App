//
//  HomeScreenViewModelTests.swift
//  Cypto LifeTests
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//

import XCTest
@testable import Cypto_Life

class HomeScreenViewModelTests: XCTestCase {
    
    var viewModel: HomeScreenViewModel!
    var mockInteractor: MockInteractor!
    var mockService: MockService!
    
    override func setUp() {
        super.setUp()
        mockService = MockService()
        mockInteractor = MockInteractor()
        viewModel = HomeScreenViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.allCoins.isEmpty)
        XCTAssertTrue(viewModel.displayedCoins.isEmpty)
    }
    
    func testGetCoinListSuccess() {
        let expectation = self.expectation(description: "Coins fetched")
        
        viewModel.onCoinsFetched = {
            XCTAssertEqual(self.viewModel.allCoins.count, 50)
            XCTAssertEqual(self.viewModel.displayedCoins.count, 20)
            expectation.fulfill()
        }
        
        mockInteractor.shouldReturnError = false
        viewModel.getCoinList()
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadNextBatch() {
        let coin1 = CryptoCoin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "", iconUrl: "", marketCap: "1000000", price: "10000", listedAt: 0, tier: 1, change: "5", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "10000", btcPrice: "10000", contractAddresses: [])
        let coin2 = CryptoCoin(uuid: "2", symbol: "ETH", name: "Ethereum", color: "", iconUrl: "", marketCap: "500000", price: "5000", listedAt: 0, tier: 1, change: "10", rank: 2, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "5000", btcPrice: "5000", contractAddresses: [])
        let coin3 = CryptoCoin(uuid: "3", symbol: "XRP", name: "Ripple", color: "", iconUrl: "", marketCap: "200000", price: "1", listedAt: 0, tier: 1, change: "0", rank: 3, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "1000", btcPrice: "1", contractAddresses: [])
        
        viewModel.allCoins = [coin1, coin2, coin3]
        
        viewModel.loadNextBatch()
        XCTAssertEqual(viewModel.displayedCoins.count, 3)

    }
    
    func testSortByPrice() {
        let coin1 = CryptoCoin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "", iconUrl: "", marketCap: "1000000", price: "10000", listedAt: 0, tier: 1, change: "5", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "10000", btcPrice: "10000", contractAddresses: [])
        let coin2 = CryptoCoin(uuid: "2", symbol: "ETH", name: "Ethereum", color: "", iconUrl: "", marketCap: "500000", price: "5000", listedAt: 0, tier: 1, change: "10", rank: 2, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "5000", btcPrice: "5000", contractAddresses: [])
        let coin3 = CryptoCoin(uuid: "3", symbol: "XRP", name: "Ripple", color: "", iconUrl: "", marketCap: "200000", price: "1", listedAt: 0, tier: 1, change: "0", rank: 3, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "1000", btcPrice: "1", contractAddresses: [])
        
        viewModel.displayedCoins = [coin1, coin2, coin3]
        
        viewModel.sortByPrice()
        XCTAssertEqual(viewModel.displayedCoins[0].name, "Bitcoin")
        XCTAssertEqual(viewModel.displayedCoins[1].name, "Ethereum")
        XCTAssertEqual(viewModel.displayedCoins[2].name, "Ripple")
    }
    
    func testSortByBestPerformance() {
        let coin1 = CryptoCoin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "", iconUrl: "", marketCap: "1000000", price: "10000", listedAt: 0, tier: 1, change: "10", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "10000", btcPrice: "10000", contractAddresses: [])
        let coin2 = CryptoCoin(uuid: "2", symbol: "ETH", name: "Ethereum", color: "", iconUrl: "", marketCap: "500000", price: "5000", listedAt: 0, tier: 1, change: "20", rank: 2, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "5000", btcPrice: "5000", contractAddresses: [])
        let coin3 = CryptoCoin(uuid: "3", symbol: "XRP", name: "Ripple", color: "", iconUrl: "", marketCap: "200000", price: "1", listedAt: 0, tier: 1, change: "5", rank: 3, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "1000", btcPrice: "1", contractAddresses: [])
        
        viewModel.displayedCoins = [coin1, coin2, coin3]
        
        viewModel.sortByBestPerformance()
        XCTAssertEqual(viewModel.displayedCoins[0].name, "Ethereum")
        XCTAssertEqual(viewModel.displayedCoins[1].name, "Bitcoin")
        XCTAssertEqual(viewModel.displayedCoins[2].name, "Ripple")
    }
    
    func testToggleFavorite() {
        let coinID = "1"
        
        viewModel.toggleFavorite(for: coinID)
        XCTAssertTrue(UserDefaults.isFavorite(coinID))
        
        viewModel.toggleFavorite(for: coinID)
        XCTAssertFalse(UserDefaults.isFavorite(coinID))
    }
}

class MockInteractor: InteractorProtocol {
    var shouldReturnError = false
    
    func getCoins(completed: @escaping (Result<CryptoResponse, Error>) -> Void) {
        if shouldReturnError {
            completed(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"])))
        } else {
            let mockCoin1 = CryptoCoin(uuid: "1", symbol: "BTC", name: "Bitcoin", color: "", iconUrl: "", marketCap: "1000000", price: "10000", listedAt: 0, tier: 1, change: "5", rank: 1, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "10000", btcPrice: "10000", contractAddresses: [])
            let mockCoin2 = CryptoCoin(uuid: "2", symbol: "ETH", name: "Ethereum", color: "", iconUrl: "", marketCap: "500000", price: "5000", listedAt: 0, tier: 1, change: "10", rank: 2, sparkline: [], lowVolume: false, coinrankingUrl: "", volume24h: "5000", btcPrice: "5000", contractAddresses: [])
            
            let mockResponse = CryptoResponse(data: CryptoData(stats: CryptoStats(total: 2, totalCoins: 2, totalMarkets: 1, totalExchanges: 1, totalMarketCap: "1500000", total24hVolume: "15000"), coins: [mockCoin1, mockCoin2]))
            completed(.success(mockResponse))
        }
    }
}

class MockService: ServiceProtocol {
    func makeGetRequest<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
    }
    
    func makePostRequest<T, U>(url: URL, body: U, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, U : Encodable {
    }
}


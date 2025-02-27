//
//  FavoriteScreenViewModelTests.swift
//  Cypto LifeTests
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//

import XCTest
@testable import Cypto_Life

class FavoriteScreenViewModelTests: XCTestCase {
    
    var viewModel: FavoriteScreenViewModel!
    
    override func setUp() {
        super.setUp()
        UserDefaults.savedFavoriteCoin = []
        viewModel = FavoriteScreenViewModel()
    }
    
    override func tearDown() {
        UserDefaults.savedFavoriteCoin = []
        viewModel = nil
        super.tearDown()
    }
    
    func testFavoriteListCount() {
        UserDefaults.savedFavoriteCoin = ["coin1", "coin2"]
        
        viewModel.favoritesList = UserDefaults.savedFavoriteCoin
        
        XCTAssertEqual(viewModel.favoriteListCount, 2)
    }
    
    func testResetFavorites() {
        UserDefaults.savedFavoriteCoin = ["coin1", "coin2"]
        
        viewModel.removeFromFavorites(coinID: "coin1")
        
        viewModel.resetFavorites()
        
        XCTAssertEqual(viewModel.favoritesList, ["coin2"])
    }
    
    func testRemoveFromFavorites() {
        UserDefaults.savedFavoriteCoin = ["coin1", "coin2", "coin3"]
        
        viewModel.removeFromFavorites(coinID: "coin2")
        
        XCTAssertEqual(UserDefaults.savedFavoriteCoin, ["coin1", "coin3"])
    }
}

//
//  CyptoResponse.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

struct CryptoResponse: Codable {
    let data: CryptoData
}

struct CryptoData: Codable {
    let stats: CryptoStats
    let coins: [CryptoCoin]
}

struct CryptoStats: Codable {
    let total: Int
    let totalCoins: Int
    let totalMarkets: Int
    let totalExchanges: Int
    let totalMarketCap: String
    let total24hVolume: String
}

struct CryptoCoin: Codable, Equatable {
    let uuid: String
    let symbol: String
    let name: String
    let color: String
    let iconUrl: String
    let marketCap: String
    let price: String
    let listedAt: Int
    let tier: Int
    let change: String
    let rank: Int
    let sparkline: [String?]
    let lowVolume: Bool
    let coinrankingUrl: String
    let volume24h: String
    let btcPrice: String
    let contractAddresses: [String]

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume, coinrankingUrl
        case volume24h = "24hVolume"
        case btcPrice, contractAddresses
    }
    
    var formattedPrice: String {
         "$\(price.prefix(8))"
     }
     
     var formattedMarketCap: String {
         "$\(marketCap.prefix(10))"
     }
     
     var formattedChange: String {
         "\(change)%"
     }
}

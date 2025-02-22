//
//  Interactor.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation

protocol InteractorProtocol {
    func getCoins(completed: @escaping (Result<CryptoResponse, Error>) -> Void)
}

class Interactor: InteractorProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getCoins(completed: @escaping (Result<CryptoResponse, Error>) -> Void) {
        let urlString = "https://api.coinranking.com/v2/coins"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InteractorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completed(.failure(error))
            return
        }
        service.makeGetRequest(url: url, completion: completed)
    }
}

//
//  FavoriteScreenViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit
import SwiftUI

class FavoriteScreenViewController: UIViewController {
    
    @IBOutlet private var favoriteCryptoListTableView: UITableView!
    var viewModel = FavoriteScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCryptoListTableView.delegate = self
        favoriteCryptoListTableView.dataSource = self
        favoriteCryptoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CryptoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetFavorites()
        favoriteCryptoListTableView.reloadData()
        print(viewModel.favoriteListCount)
    }
}

extension FavoriteScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAVORITE_CRYPTO_CELL", for: indexPath)
        
        guard let coin = viewModel.favoritesList[safe: indexPath.row] else { return cell }
        
        cell.contentConfiguration = UIHostingConfiguration {
            CryptoCellView(coin: coin)
                .padding(.vertical, 5)
        }
        
        return cell
    }
}

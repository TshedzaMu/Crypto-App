//
//  HomeScreenViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit
import SwiftUI

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var cryptoListTableView: UITableView!
    
     lazy var viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cryptoListTableView.delegate = self
        cryptoListTableView.dataSource = self
        
        viewModel.onCoinsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.cryptoListTableView.reloadData()
            }
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
        
        }
        
        viewModel.getCoinList()
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayedCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CRYPTO_CELL", for: indexPath)
        
        guard let coin = viewModel.displayedCoins[safe: indexPath.row] else { return cell }
        
        cell.contentConfiguration = UIHostingConfiguration {
            CryptoCellView(coin: coin)
                .padding(.vertical, 5)
        }

        if indexPath.row == viewModel.displayedCoins.count - 1 {
            viewModel.loadMoreCoins()
        }
        
        return cell
    }
}


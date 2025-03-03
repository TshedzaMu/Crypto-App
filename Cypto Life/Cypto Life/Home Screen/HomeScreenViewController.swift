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
        startActivityIndicator()
        super.viewDidLoad()
        cryptoListTableView.delegate = self
        cryptoListTableView.dataSource = self
        setupNavigationBar()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onCoinsFetched = { [weak self] in
            self?.stopActivityIndicator()
            DispatchQueue.main.async {
                self?.cryptoListTableView.reloadData()
            }
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
            self?.stopActivityIndicator()
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
        viewModel.getCoinList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coinInformationSegue" {
            if let coinInformationVC = segue.destination as? CoinDetailsViewController {
                coinInformationVC.viewModel.selectedCoin = viewModel.selectedCoin
            }
        }
    }
    
    private func setupNavigationBar() {
        let sortMenu = UIMenu(title: "Sort By", children: [
            UIAction(title: "All", handler: { _ in self.viewModel.getCoinList() }),
            UIAction(title: "Highest Price", handler: { _ in self.viewModel.sortByPrice() }),
            UIAction(title: "Best Performance", handler: { _ in self.viewModel.sortByBestPerformance() })
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", menu: sortMenu)
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - height {
            viewModel.loadNextBatchIfNeeded(currentIndex: viewModel.displayedCoins.count)
        }
    }
    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cryptoInfo = viewModel.displayedCoins[indexPath.row]
        viewModel.selectedCoin = cryptoInfo
        performSegue(withIdentifier: "coinInformationSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coinID = viewModel.displayedCoins[indexPath.row].uuid
        let isFavorite = UserDefaults.isFavorite(coinID)
        
        let favoriteAction = UIContextualAction(style: .normal, title: isFavorite ? "Remove Favorite" : "Add Favorite") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(for: coinID)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        favoriteAction.backgroundColor = isFavorite ? .darkGray : .lightGray
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

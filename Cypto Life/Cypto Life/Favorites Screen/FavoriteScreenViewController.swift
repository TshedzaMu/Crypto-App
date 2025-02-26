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
    private var emptyStateView: UIView!
    
    var viewModel = FavoriteScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCryptoListTableView.delegate = self
        favoriteCryptoListTableView.dataSource = self
        
        setupEmptyStateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetFavorites()
        favoriteCryptoListTableView.reloadData()
        toggleEmptyStateView()
    }
    
    private func setupEmptyStateView() {
        emptyStateView = UIView(frame: view.bounds)
        emptyStateView.backgroundColor = .systemBackground
        
        let messageLabel = UILabel()
        messageLabel.text = "No favorite coins yet.\nStart adding some!"
        messageLabel.textAlignment = .center
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        emptyStateView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor)
        ])
        
        view.addSubview(emptyStateView)
    }
    
    private func toggleEmptyStateView() {
        viewModel.resetFavorites()
        emptyStateView.isHidden = viewModel.favoriteListCount > 0
        favoriteCryptoListTableView.isHidden = viewModel.favoriteListCount == 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteCoinInformationSegue" {
            if let coinInformationVC = segue.destination as? CoinDetailsViewController {
                coinInformationVC.viewModel.selectedCoin = viewModel.selectedCoin
            }
        }
    }
}

extension FavoriteScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toggleEmptyStateView()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cryptoInfo = viewModel.favoritesList[indexPath.row]
        viewModel.selectedCoin = cryptoInfo
        performSegue(withIdentifier: "favoriteCoinInformationSegue", sender: nil)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = viewModel.favoritesList[indexPath.row]
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Remove Favorite") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            viewModel.removeFromFavorites(coin: coin)
            viewModel.resetFavorites()
            favoriteCryptoListTableView.reloadData()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        favoriteAction.backgroundColor = .darkGray
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

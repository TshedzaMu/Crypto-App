//
//  CoinDetailsViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit
import SwiftUI

class CoinDetailsViewController: UIViewController {
    
    lazy var viewModel = CoinDetailsViewModel()
    var favoriteButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let coinDetailsView = CoinDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: coinDetailsView)
            
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        updateFavoriteButton()
    }
    
    private func setupNavigationBar() {
          favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(toggleFavorite))
          navigationItem.rightBarButtonItem = favoriteButton
      }
      
      private func updateFavoriteButton() {
          guard let uuid = viewModel.selectedCoin?.uuid else { return  }
          let isFavorite = UserDefaults.isFavorite(uuid)
          let imageName = isFavorite ? "star.fill" : "star"
          favoriteButton?.image = UIImage(systemName: imageName)
      }
      
    @objc private func toggleFavorite() {
        guard let coin = viewModel.selectedCoin?.uuid else { return }
        
        if UserDefaults.isFavorite(coin) {
            viewModel.removeFromFavorites(coinID: coin)
        } else {
            viewModel.addToFavorites(coinID: coin)
        }
        
        updateFavoriteButton()
    }
}

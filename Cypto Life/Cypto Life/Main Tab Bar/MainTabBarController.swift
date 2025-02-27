//
//  MainTabBarController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//

import UIKit

class MainTabBarController: UITabBarController {
    let dataTransporter = CryptoCoinDataTransporter()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let homeVC = viewControllers?[0] as? HomeScreenViewController,
           let favoriteVC = viewControllers?[1] as? FavoriteScreenViewController {
            homeVC.dataTransporter = self.dataTransporter
            favoriteVC.dataTransporter = self.dataTransporter
        }
    }
}


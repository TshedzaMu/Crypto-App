//
//  CoinDetailsViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

class CoinDetailsViewController: UIViewController {
    
    lazy var viewModel = CoinDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(viewModel.selectedCoin)
    }
}

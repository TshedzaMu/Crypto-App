//
//  HomeScreenViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
    
     lazy var viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onCoinsFetched = { [weak self] in
            
        }
        
        viewModel.onFetchFailed = { [weak self] errorMessage in
        
        }
        
        viewModel.getCoinList()
    }
}

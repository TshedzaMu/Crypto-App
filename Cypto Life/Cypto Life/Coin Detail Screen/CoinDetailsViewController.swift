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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let coinDetailsView = CoinDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: coinDetailsView)
            
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}

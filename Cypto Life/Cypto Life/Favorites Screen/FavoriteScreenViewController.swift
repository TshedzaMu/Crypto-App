//
//  FavoriteScreenViewController.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import Foundation
import UIKit

class FavoriteScreenViewController: UIViewController {
    
    @IBOutlet private var favoriteCryptoListTableView: UITableView!
    
    override func viewDidLoad() {
        favoriteCryptoListTableView.delegate = self
        favoriteCryptoListTableView.dataSource = self
        super.viewDidLoad()
    }
}

extension FavoriteScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

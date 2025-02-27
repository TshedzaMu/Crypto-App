//
//  Array+Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

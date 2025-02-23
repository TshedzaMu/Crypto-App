//
//  FilterView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI

struct FilterView: View {
    @State private var selectedFilter = "24H"
    let filters = ["24H", "7D", "1M", "1Y"]

    var body: some View {
        HStack {
            ForEach(filters, id: \.self) { filter in
                Button(action: {
                    selectedFilter = filter
                }) {
                    Text(filter)
                        .padding()
                        .background(selectedFilter == filter ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}


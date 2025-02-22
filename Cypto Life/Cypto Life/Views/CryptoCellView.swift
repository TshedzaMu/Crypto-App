//
//  CryptoCellView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import SwiftUI

struct CryptoCellView: View {
    let coin: CryptoCoin
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.iconUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.headline)
                Text("$\(coin.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text("\(coin.change)%")
                .foregroundColor(Double(coin.change) ?? 0 >= 0 ? .green : .red)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 3))
    }
}

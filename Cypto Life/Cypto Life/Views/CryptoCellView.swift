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
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.trailing, 15)
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("$\(coin.price)")
                    .font(.body)
                    .foregroundColor(.black)
            }
            Spacer()
            
            Text("\(coin.change)%")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(Double(coin.change) ?? 0 >= 0 ? .green : .red)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 4))
    }
}

//
//  CryptoCellView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/22.
//

import SwiftUI
import UIKit
import WebKit

import SwiftUI

struct CryptoCellView: View {
    let coin: CryptoCoin
    @State private var svgImage: UIImage?
    @State private var isFavorite: Bool = false

    var body: some View {
        HStack {
            if isSVG(url: coin.iconUrl) {
                if let image = svgImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .onAppear {
                            loadSVGImage(from: coin.iconUrl)
                        }
                }
            } else {
                AsyncImage(url: URL(string: coin.iconUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }

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
        .background(
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 4)

                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(.blue)
                    .font(.system(size: 14))
                    .offset(x: -8, y: 8)
            }
        )
        .onAppear {
            isFavorite = UserDefaults.isFavorite(coin.uuid)
        }
    }

    private func isSVG(url: String) -> Bool {
        return url.lowercased().hasSuffix(".svg")
    }

    private func loadSVGImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            SVGLoader.load(data: data, url: urlString) { image in
                DispatchQueue.main.async {
                    svgImage = image
                }
            }
        }.resume()
    }
}

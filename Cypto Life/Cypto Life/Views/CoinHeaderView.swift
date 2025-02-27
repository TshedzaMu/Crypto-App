//
//  CoinHeaderView.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/23.
//

import SwiftUI

struct CoinHeaderView: View {
    let coin: CryptoCoin
    @State private var svgImage: UIImage?

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
                    .font(.title)
                    .bold()
                Text(coin.symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(coin.formattedPrice)
                .font(.title2)
        }
        .padding()
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

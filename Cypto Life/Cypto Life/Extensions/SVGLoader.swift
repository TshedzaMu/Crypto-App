//
//  SVGLoader.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/26.
//

import Foundation
import WebKit
import UIKit

class SVGLoader {
    typealias wkType = (data: Data, completion: ((UIImage?) -> Void)?, url: String?)
    static var wkContainer = [wkType]()
    static var wView: WKView?
    
    static func load(data: Data, url: String?, size: CGSize = CGSize(width: 600, height: 600), completion: @escaping ((UIImage?) -> Void)) {
        let wkData: wkType = (data, completion, url)
        wkContainer.append(wkData)
        
        DispatchQueue.main.async {
            if wView == nil {
                wView = WKView(frame: CGRect(origin: .zero, size: size))
            }
        }
    }
    
    static func clean() {
        DispatchQueue.main.async {
            if wkContainer.isEmpty {
                wView = nil
            }
        }
    }
    
    class WKView: NSObject, WKNavigationDelegate {
        var webKitView: WKWebView?
        
        init(frame: CGRect) {
            super.init()
            DispatchQueue.main.async {
                self.webKitView = WKWebView(frame: frame)
                self.webKitView?.navigationDelegate = self
                self.webKitView?.isOpaque = false
                self.webKitView?.backgroundColor = .clear
                self.webKitView?.scrollView.backgroundColor = .clear
                self.loadData()
            }
        }
        
        func loadData() {
            let datas = SVGLoader.wkContainer
            if datas.isEmpty { return }
            
            guard let data = datas.first?.data else { return }
            let urlS = datas.first?.url ?? ""
            let url = URL(string: urlS) ?? URL(string: "about:blank")!
            
            DispatchQueue.main.async {
                self.webKitView?.load(data, mimeType: "image/svg+xml", characterEncodingName: "utf-8", baseURL: url)
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.takeSnapshot(with: nil) { [weak self] image, error in
                DispatchQueue.main.async {
                    SVGLoader.wkContainer.first?.completion?(image)
                    SVGLoader.wkContainer.removeFirst()
                    self?.loadData()
                    SVGLoader.clean()
                }
            }
        }
    }
}
